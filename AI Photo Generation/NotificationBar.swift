import SwiftUI

struct NotificationBar: View {
    @ObservedObject var notificationManager: NotificationManager
    
    var body: some View {
        if !notificationManager.notifications.isEmpty {
            VStack(spacing: 8) {
                ForEach(notificationManager.notifications) { notification in
                    NotificationCard(
                        notification: notification,
                        onDismiss: {
                            notificationManager.dismissNotification(id: notification.id)
                        }
                    )
                }
            }
            .padding(.horizontal, 12)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}

// MARK: - Individual Notification Card
struct NotificationCard: View {
    let notification: NotificationData
    let onDismiss: () -> Void
    
    @State private var shimmer = false
    @State private var pulseAnimation = false
    
    var body: some View {
        VStack(spacing: 0) {
                HStack(spacing: 12) {
                    // Thumbnail Image with circular animation
                    if let image = notification.thumbnailImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .shadow(color: Color.blue.opacity(0.3), radius: 4, x: 0, y: 2)
                            .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: pulseAnimation)
                    } else {
                        // Default icon if no image
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 22))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: pulseAnimation)
                    }
                    
                    // Text Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(notification.title)
                            .font(.custom("Nunito-Bold", size: 14))
                            .foregroundColor(.primary)
                        
                        Text(notification.message)
                            .font(.custom("Nunito-Regular", size: 12))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                        
                        // Progress Bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // Background
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 6)
                                
                                // Progress Fill with gradient
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(
                                        LinearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * notification.progress, height: 6)
                                    .overlay(
                                        // Shimmer effect
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.0),
                                                Color.white.opacity(0.6),
                                                Color.white.opacity(0.0)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .rotationEffect(.degrees(20))
                                        .offset(x: shimmer ? 200 : -200)
                                        .mask(RoundedRectangle(cornerRadius: 4))
                                    )
                            }
                        }
                        .frame(height: 6)
                        
                        Text("\(Int(notification.progress * 100))% • View in Profile when complete")
                            .font(.custom("Nunito-Regular", size: 10))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Close Button
                    Button(action: onDismiss) {
                        ZStack {
                            Circle()
                                .fill(Color.secondary.opacity(0.2))
                                .frame(width: 28, height: 28)
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        // Background blur
                        Color.clear.background(.ultraThinMaterial)
                        
                        // Subtle gradient overlay
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.05),
                                Color.purple.opacity(0.05)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                )
            }
            .transition(.asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .scale(scale: 0.8).combined(with: .opacity)
            ))
            .onAppear {
                pulseAnimation = true
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    shimmer = true
                }
            }
        }
    }

