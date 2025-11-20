import SwiftUI

// MARK: - Video Generation Extension
extension NotificationManager {
    /// Start a background video generation task that persists across view changes
    @MainActor
    func startBackgroundVideoGeneration(
        item: InfoPacket,
        image: UIImage,
        userId: String,
        onVideoGenerated: @escaping (String) -> Void = { _ in }
    ) -> UUID {
        let taskId = UUID()
        
        // Show notification immediately and store its ID
        let notificationId = showNotification(
            title: "Creating Your Video",
            message: "Generating your \(item.title)...",
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
            --- WaveSpeed Video Request Info ---
            ------------------------------------
            Endpoint: \(item.endpoint)
            Prompt: \(item.prompt.isEmpty ? "(no prompt)" : "\(item.prompt)")
            Aspect Ratio: \(item.aspectRatio ?? "default")
            Output Format: \(item.outputFormat)
            Enable Sync Mode: \(item.enableSyncMode)
            Cost: \(item.cost)
            ------------------------------------
            """)
            
            do {
                // Initial progress
                await self.updateProgress(0.1, for: notificationId)
                await self.updateMessage("Sending image to AI...", for: notificationId)
                
                // Call API with timeout (videos take longer)
                // Videos: 120 polls × 5 seconds = 600 seconds (10 minutes)
                let response = try await withTimeout(seconds: 650) { // 10 minutes + buffer
                    try await sendImageToWaveSpeed(
                        image: image,
                        prompt: item.prompt,
                        aspectRatio: item.aspectRatio,
                        outputFormat: item.outputFormat,
                        enableSyncMode: item.enableSyncMode,
                        enableBase64Output: item.enableBase64Output,
                        endpoint: item.endpoint,
                        maxPollingAttempts: 120,  // 120 × 5s = 10 minutes for video generation
                        userId: userId
                    )
                }
                
                await self.updateProgress(0.3, for: notificationId)
                await self.updateMessage("Processing video generation...", for: notificationId)
                
                print("✅ Video request sent. Response received.")
                
                if let urlString = response.data.outputs?.first, let url = URL(string: urlString) {
                    await self.updateProgress(0.5, for: notificationId)
                    await self.updateMessage("Downloading video...", for: notificationId)
                    
                    print("[WaveSpeed] Fetching generated video from: \(urlString)")
                    
                    // Download video with extended timeout
                    let (videoData, response) = try await withTimeout(seconds: 120) {
                        try await URLSession.shared.data(from: url)
                    }
                    
                    print("[WaveSpeed] Video downloaded, size: \(videoData.count) bytes")
                    
                    // Detect file extension from response or URL
                    var fileExtension = "mp4" // Default
                    if let mimeType = (response as? HTTPURLResponse)?.mimeType {
                        if mimeType.contains("webm") {
                            fileExtension = "webm"
                        } else if mimeType.contains("quicktime") {
                            fileExtension = "mov"
                        }
                    } else if urlString.hasSuffix(".webm") {
                        fileExtension = "webm"
                    } else if urlString.hasSuffix(".mov") {
                        fileExtension = "mov"
                    }
                    
                    await self.updateProgress(0.6, for: notificationId)
                    await self.updateMessage("Generating thumbnail...", for: notificationId)
                    
                    // Generate thumbnail (optional, don't fail if this doesn't work)
                    let thumbnail = await SupabaseManager.shared.generateVideoThumbnail(from: videoData)
                    var thumbnailUrl: String? = nil
                    
                    if let thumbnail = thumbnail {
                        await self.updateProgress(0.65, for: notificationId)
                        await self.updateMessage("Uploading thumbnail...", for: notificationId)
                        
                        do {
                            // Try to upload thumbnail with shorter timeout
                            thumbnailUrl = try await SupabaseManager.shared.uploadImage(
                                image: thumbnail,
                                userId: userId,
                                modelName: "\(item.modelName)_thumbnail",
                                maxRetries: 2  // Only 2 retries for thumbnail
                            )
                            print("✅ Thumbnail uploaded: \(thumbnailUrl ?? "none")")
                        } catch {
                            print("⚠️ Failed to upload thumbnail (continuing anyway): \(error)")
                            // Don't fail the whole operation if thumbnail upload fails
                            // The video will still be uploaded and can be viewed without thumbnail
                        }
                    } else {
                        print("⚠️ Could not generate thumbnail (continuing anyway)")
                    }
                    
                    await self.updateProgress(0.75, for: notificationId)
                    await self.updateMessage("Uploading video to storage...", for: notificationId)
                    
                    // Upload video to Supabase Storage
                    let modelName = item.modelName
                    let supabaseVideoURL: String
                    
                    do {
                        supabaseVideoURL = try await SupabaseManager.shared.uploadVideo(
                            videoData: videoData,
                            userId: userId,
                            modelName: modelName.isEmpty ? "unknown" : modelName,
                            fileExtension: fileExtension
                        )
                        print("✅ Video uploaded to Supabase Storage: \(supabaseVideoURL)")
                    } catch {
                        print("❌ Failed to upload video to Supabase Storage: \(error)")
                        throw error
                    }
                    
                    await self.updateProgress(0.9, for: notificationId)
                    await self.updateMessage("Saving to profile...", for: notificationId)
                    
                    // Prepare metadata for database insert
                    let metadata = VideoMetadata(
                        userId: userId,
                        videoUrl: supabaseVideoURL,
                        thumbnailUrl: thumbnailUrl,
                        model: modelName.isEmpty ? nil : modelName,
                        title: item.title.isEmpty ? nil : item.title,
                        cost: item.cost > 0 ? item.cost : nil,
                        type: item.type?.isEmpty == false ? item.type : nil,
                        endpoint: item.endpoint.isEmpty ? nil : item.endpoint,
                        fileExtension: fileExtension,
                        prompt: item.prompt.isEmpty ? nil : item.prompt,
                        aspectRatio: item.aspectRatio
                    )
                    
                    print("📝 Saving video metadata: title=\(metadata.title ?? "none"), cost=\(metadata.cost ?? 0), type=\(metadata.type ?? "none"), extension=\(fileExtension)")
                    
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
                            print("✅ Video metadata saved to database")
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
                    
                    // Notify completion
                    await MainActor.run {
                        onVideoGenerated(supabaseVideoURL)
                    }
                    
                    // Mark as complete
                    await self.markAsCompleted(id: notificationId, message: "✅ Video created successfully!")
                    
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
                    errorMessage: "Request timed out. Videos can take several minutes."
                )
                await self.cleanupTask(taskId: taskId)
            } catch let error as URLError {
                print("❌ Network error: \(error)")
                let message: String
                switch error.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    message = "No internet connection. Please check your network."
                case .timedOut:
                    message = "Request timed out. Videos can take longer to generate."
                case .cannotFindHost, .cannotConnectToHost:
                    message = "Cannot reach server. Please try again later."
                default:
                    message = "Network error: \(error.localizedDescription)"
                }
                await self.markAsFailed(id: notificationId, errorMessage: message)
                await self.cleanupTask(taskId: taskId)
            } catch {
                print("❌ WaveSpeed video error: \(error)")
                await self.markAsFailed(
                    id: notificationId,
                    errorMessage: "Video generation failed: \(error.localizedDescription)"
                )
                await self.cleanupTask(taskId: taskId)
            }
        }
        
        // Store the task reference
        backgroundTasks[taskId] = backgroundTask
        
        return taskId
    }
}

