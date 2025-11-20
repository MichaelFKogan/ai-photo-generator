import SwiftUI

// MARK: - Image Generation Extension
extension NotificationManager {
    /// Start a background image generation task that persists across view changes
    @MainActor
    func startBackgroundGeneration(
        item: InfoPacket,
        image: UIImage,
        userId: String,
        onImageGenerated: @escaping (UIImage) -> Void = { _ in }
    ) -> UUID {
        let taskId = UUID()
        
        // Show notification immediately and store its ID
        let notificationId = showNotification(
            title: "Transforming Your Photo",
            message: "Creating your \(item.title)...",
            progress: 0.0,
            thumbnailImage: image
        )
        
        // Store task info
        generationTasks[taskId] = GenerationTaskInfo(
            taskId: taskId,
            notificationId: notificationId,
            generatedImage: nil
        )
        
        // Create a detached task that runs independently of view lifecycle
        let backgroundTask = Task.detached { [weak self] in
            guard let self = self else { return }
            
            print("""
            --- WaveSpeed Request Info ---
            ------------------------------
            Endpoint: \(item.endpoint)
            Prompt: \(item.prompt.isEmpty ? "(no prompt)" : "\(item.prompt)")
            Aspect Ratio: \(item.aspectRatio ?? "default")
            Output Format: \(item.outputFormat)
            Enable Sync Mode: \(item.enableSyncMode)
            Enable Base64 Output: \(item.enableBase64Output)
            Cost: \(item.cost)
            ------------------------------
            """)
            
            do {
                // Initial progress
                await self.updateProgress(0.1, for: notificationId)
                await self.updateMessage("Sending image to AI...", for: notificationId)
                
                // Call API with timeout
                // Images: 60 polls × 5 seconds = 300 seconds (5 minutes)
                let response = try await withTimeout(seconds: 360) { // 6 minutes
                    try await sendImageToWaveSpeed(
                        image: image,
                        prompt: item.prompt,
                        aspectRatio: item.aspectRatio,
                        outputFormat: item.outputFormat,
                        enableSyncMode: item.enableSyncMode,
                        enableBase64Output: item.enableBase64Output,
                        endpoint: item.endpoint,
                        maxPollingAttempts: 60,  // 60 × 5s = 5 minutes for image generation
                        userId: userId
                    )
                }
                
                await self.updateProgress(0.5, for: notificationId)
                await self.updateMessage("Processing transformation...", for: notificationId)
                
                print("✅ Image sent. Response received.")
                
                if let urlString = response.data.outputs?.first, let url = URL(string: urlString) {
                    await self.updateProgress(0.6, for: notificationId)
                    await self.updateMessage("Downloading result...", for: notificationId)
                    
                    print("[WaveSpeed] Fetching generated image…")
                    
                    // Download with timeout
                    let (imageData, _) = try await withTimeout(seconds: 30) {
                        try await URLSession.shared.data(from: url)
                    }
                    
                    guard let downloadedImage = UIImage(data: imageData) else {
                        throw NSError(domain: "ImageError", code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "Failed to decode image"])
                    }
                    
                    print("[WaveSpeed] Generated image loaded successfully.")
                    
                    await self.updateProgress(0.75, for: notificationId)
                    await self.updateMessage("Uploading to storage...", for: notificationId)
                    
                    // Upload image to Supabase Storage
                    let modelName = item.modelName
                    let supabaseImageURL: String
                    
                    do {
                        supabaseImageURL = try await SupabaseManager.shared.uploadImage(
                            image: downloadedImage,
                            userId: userId,
                            modelName: modelName.isEmpty ? "unknown" : modelName
                        )
                        print("✅ Image uploaded to Supabase Storage: \(supabaseImageURL)")
                    } catch {
                        print("❌ Failed to upload to Supabase Storage: \(error)")
                        throw error
                    }
                    
                    await self.updateProgress(0.9, for: notificationId)
                    await self.updateMessage("Saving to profile...", for: notificationId)
                    
                    // Prepare metadata for database insert - only add non-empty fields
                    let metadata = ImageMetadata(
                        userId: userId,
                        imageUrl: supabaseImageURL,
                        model: modelName.isEmpty ? nil : modelName,
                        title: item.title.isEmpty ? nil : item.title,
                        cost: item.cost > 0 ? item.cost : nil,
                        type: item.type?.isEmpty == false ? item.type : nil,
                        endpoint: item.endpoint.isEmpty ? nil : item.endpoint
                    )
                    
                    print("📝 Saving metadata: title=\(metadata.title ?? "none"), cost=\(metadata.cost ?? 0), type=\(metadata.type ?? "none")")
                    
                    // Save to Supabase database with retry logic
                    var saveSuccessful = false
                    var retryCount = 0
                    let maxRetries = 3
                    
                    while !saveSuccessful && retryCount < maxRetries {
                        do {
                            try await SupabaseManager.shared.client.database
                                .from("user_media")
                                .insert(metadata)
                                .execute()
                            print("✅ Image metadata saved to database")
                            saveSuccessful = true
                        } catch {
                            retryCount += 1
                            print("⚠️ Save attempt \(retryCount) failed: \(error)")
                            
                            if retryCount < maxRetries {
                                // Wait before retrying (exponential backoff)
                                try await Task.sleep(for: .seconds(pow(2.0, Double(retryCount))))
                            } else {
                                print("❌ Failed to save to database after \(maxRetries) attempts: \(error)")
                                // Still mark as completed but log the error
                            }
                        }
                    }
                    
                    // Store generated image
                    await MainActor.run {
                        if var taskInfo = self.generationTasks[taskId] {
                            taskInfo.generatedImage = downloadedImage
                            self.generationTasks[taskId] = taskInfo
                        }
                        onImageGenerated(downloadedImage)
                    }
                    
                    // Mark as complete
                    await self.markAsCompleted(id: notificationId)
                    
                    // Auto-dismiss after 5 seconds
                    try? await Task.sleep(for: .seconds(5))
                    await self.dismissNotification(id: notificationId)
                    
                    // Clean up task tracking
                    await MainActor.run {
                        self.generationTasks.removeValue(forKey: taskId)
                        self.backgroundTasks.removeValue(forKey: taskId)
                    }
                } else {
                    throw NSError(domain: "APIError", code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "No output URL returned from API"])
                }
            } catch let error as TimeoutError {
                print("❌ Timeout: \(error.localizedDescription)")
                await self.markAsFailed(
                    id: notificationId,
                    errorMessage: "Request timed out. Please try again."
                )
                await self.cleanupTask(taskId: taskId)
            } catch let error as URLError {
                print("❌ Network error: \(error)")
                let message: String
                switch error.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    message = "No internet connection. Please check your network."
                case .timedOut:
                    message = "Request timed out. Please try again."
                case .cannotFindHost, .cannotConnectToHost:
                    message = "Cannot reach server. Please try again later."
                default:
                    message = "Network error: \(error.localizedDescription)"
                }
                await self.markAsFailed(id: notificationId, errorMessage: message)
                await self.cleanupTask(taskId: taskId)
            } catch {
                print("❌ WaveSpeed error: \(error)")
                await self.markAsFailed(
                    id: notificationId,
                    errorMessage: "Generation failed: \(error.localizedDescription)"
                )
                await self.cleanupTask(taskId: taskId)
            }
        }
        
        // Store the task reference
        backgroundTasks[taskId] = backgroundTask
        
        return taskId
    }
}

