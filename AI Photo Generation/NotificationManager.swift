import SwiftUI

// MARK: - Notification State
enum NotificationState {
    case inProgress
    case completed
    case failed
}

// MARK: - Notification Data Model
struct NotificationData: Identifiable {
    let id: UUID
    var title: String
    var message: String
    var progress: Double // 0.0 to 1.0
    var thumbnailImage: UIImage?
    var isActive: Bool
    var state: NotificationState
    var errorMessage: String?
    
    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        progress: Double = 0.0,
        thumbnailImage: UIImage? = nil,
        isActive: Bool = true,
        state: NotificationState = .inProgress,
        errorMessage: String? = nil
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.progress = progress
        self.thumbnailImage = thumbnailImage
        self.isActive = isActive
        self.state = state
        self.errorMessage = errorMessage
    }
}

// MARK: - Generation Task Info
struct GenerationTaskInfo {
    let taskId: UUID
    let notificationId: UUID
    var generatedImage: UIImage?
}

// MARK: - Image Metadata for Database
struct ImageMetadata: Encodable {
    let user_id: String
    let image_url: String
    let model: String?
    let title: String?
    let cost: Double?
    let type: String?
    let endpoint: String?
    
    init(userId: String, imageUrl: String, model: String? = nil, title: String? = nil, cost: Double? = nil, type: String? = nil, endpoint: String? = nil) {
        self.user_id = userId
        self.image_url = imageUrl
        self.model = model
        self.title = title
        self.cost = cost
        self.type = type
        self.endpoint = endpoint
    }
}

// MARK: - Global Notification Manager
class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var notifications: [NotificationData] = []
    @Published var generationTasks: [UUID: GenerationTaskInfo] = [:]
    
    private var backgroundTasks: [UUID: Task<Void, Never>] = [:]
    
    private init() {}
    
    /// Creates and shows a new notification, returns its ID for future updates
    @discardableResult
    func showNotification(
        title: String,
        message: String,
        progress: Double = 0.0,
        thumbnailImage: UIImage? = nil
    ) -> UUID {
        let notification = NotificationData(
            title: title,
            message: message,
            progress: progress,
            thumbnailImage: thumbnailImage,
            isActive: true
        )
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            notifications.append(notification)
        }
        
        return notification.id
    }
    
    /// Update progress for a specific notification by ID
    func updateProgress(_ progress: Double, for id: UUID) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            notifications[index].progress = progress
        }
    }
    
    /// Update message for a specific notification by ID
    func updateMessage(_ message: String, for id: UUID) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        notifications[index].message = message
    }
    
    /// Update title for a specific notification by ID
    func updateTitle(_ title: String, for id: UUID) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        notifications[index].title = title
    }
    
    /// Dismiss a specific notification by ID
    func dismissNotification(id: UUID) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            notifications.removeAll { $0.id == id }
        }
    }
    
    /// Dismiss all notifications
    func dismissAllNotifications() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            notifications.removeAll()
        }
    }
    
    /// Mark notification as completed
    func markAsCompleted(id: UUID, message: String = "✅ Transformation complete!") {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            notifications[index].state = .completed
            notifications[index].progress = 1.0
            notifications[index].message = message
        }
    }
    
    /// Mark notification as failed with error message
    func markAsFailed(id: UUID, errorMessage: String) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            notifications[index].state = .failed
            notifications[index].errorMessage = errorMessage
            notifications[index].message = "❌ Failed"
        }
    }
    
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
            Prompt: \(item.prompt)
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
                let response = try await withTimeout(seconds: 180) { // 3 minutes
                    try await sendImageToWaveSpeed(
                        image: image,
                        prompt: item.prompt,
                        aspectRatio: item.aspectRatio,
                        outputFormat: item.outputFormat,
                        enableSyncMode: item.enableSyncMode,
                        enableBase64Output: item.enableBase64Output,
                        endpoint: item.endpoint
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
                                .from("user_images")
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
    
    /// Clean up task tracking
    @MainActor
    private func cleanupTask(taskId: UUID) {
        generationTasks.removeValue(forKey: taskId)
        backgroundTasks.removeValue(forKey: taskId)
    }
    
    /// Get generated image for a task
    func getGeneratedImage(for taskId: UUID) -> UIImage? {
        return generationTasks[taskId]?.generatedImage
    }
}

// MARK: - Timeout Helper
struct TimeoutError: LocalizedError {
    var errorDescription: String? {
        "The operation timed out"
    }
}

func withTimeout<T>(seconds: TimeInterval, operation: @escaping () async throws -> T) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        // Add the actual operation
        group.addTask {
            try await operation()
        }
        
        // Add the timeout task
        group.addTask {
            try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            throw TimeoutError()
        }
        
        // Return the first result (either success or timeout)
        guard let result = try await group.next() else {
            throw TimeoutError()
        }
        
        // Cancel remaining tasks
        group.cancelAll()
        
        return result
    }
}
