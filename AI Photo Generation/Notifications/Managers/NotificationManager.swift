import SwiftUI

// MARK: - Global Notification Manager
class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var notifications: [NotificationData] = []
    @Published var generationTasks: [UUID: GenerationTaskInfo] = [:]
    
    var backgroundTasks: [UUID: Task<Void, Never>] = [:]
    
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
    
    /// Clean up task tracking
    @MainActor
    func cleanupTask(taskId: UUID) {
        generationTasks.removeValue(forKey: taskId)
        backgroundTasks.removeValue(forKey: taskId)
    }
    
    /// Get generated image for a task
    func getGeneratedImage(for taskId: UUID) -> UIImage? {
        return generationTasks[taskId]?.generatedImage
    }
}
