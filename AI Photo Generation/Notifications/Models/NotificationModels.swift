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





