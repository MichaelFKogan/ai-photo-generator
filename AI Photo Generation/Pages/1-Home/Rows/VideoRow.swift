//
//  VideoRow.swift.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/16/25.
//

import SwiftUI
import AVKit

struct VideoRow: View {
    let title: String
    let items: [TrendingItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.custom("Nunito-Black", size: 20))
                    .padding(.horizontal)
                Spacer()
                Text("See All")
                    .font(.custom("Nunito-Bold", size: 12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .overlay(
                        Capsule()
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
                    .padding(.trailing, 2)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: TrendingDetailView(item: item)) {
                            VStack(spacing: 8) {
                                if let url = Bundle.main.url(forResource: item.imageName, withExtension: "mp4") {
                                    VideoThumbnail(url: url)
                                        .frame(width: 160, height: 236)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
                                        .overlay(alignment: .bottom) {
                                            Text("Try This")
                                                .font(.custom("Nunito-Black", size: 12))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(Color.black.opacity(0.8))
                                                .clipShape(Capsule())
                                                .padding(.bottom, 8)
                                        }
                                }
                                
                                Text(item.title)
                                    .font(.custom("Nunito-ExtraBold", size: 11))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - AVPlayerLayer-based VideoThumbnail with placeholder
struct VideoThumbnail: View {
    let url: URL
    @State private var isReady = false

    var body: some View {
        ZStack {
            if isReady {
                VideoPlayerContainer(url: url)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                VideoPlaceholder()
            }
        }
        .onAppear {
            // Simulate loading delay so placeholder is visible
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeOut(duration: 0.3)) {
                    isReady = true
                }
            }
        }
    }
}



// MARK: - UIViewRepresentable wrapper for AVPlayerLayer
struct VideoPlayerContainer: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> VideoPlayerUIView {
        let view = VideoPlayerUIView()
        view.configure(url: url)
        return view
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) { }
}

// MARK: - UIView holding AVQueuePlayer and looper
class VideoPlayerUIView: UIView {
    private var playerLayer: AVPlayerLayer?
    private var player: AVQueuePlayer?

    func configure(url: URL) {
        player = VideoPlayerManager.shared.player(for: url)
        
        // Remove old layer
        playerLayer?.removeFromSuperlayer()
        
        // Add new layer
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        layer.frame = bounds
        self.layer.addSublayer(layer)
        playerLayer = layer

        // Observe app coming to foreground
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)

        // Start playback
        player?.play()
    }
    
    @objc private func appWillEnterForeground() {
        player?.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



class VideoPlayerManager {
    static let shared = VideoPlayerManager()
    private var players: [URL: (player: AVQueuePlayer, looper: AVPlayerLooper)] = [:]
    
    func player(for url: URL) -> AVQueuePlayer {
        if let existing = players[url] {
            return existing.player
        }
        let item = AVPlayerItem(url: url)
        let queue = AVQueuePlayer()
        let looper = AVPlayerLooper(player: queue, templateItem: item)
        queue.isMuted = true
        queue.play()
        players[url] = (queue, looper)
        return queue
    }
}



struct VideoPlaceholder: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var animate = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.gray.opacity(colorScheme == .dark ? 0 : 0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.gray.opacity(0.25))
                )

            // Shimmer gradient sweep
            GeometryReader { proxy in
                let width = proxy.size.width

                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.0),
                                Color.white.opacity(colorScheme == .dark ? 0.25 : 0.7),
                                Color.white.opacity(0.0)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: width * 0.45)
                    .offset(x: animate ? width : -width)
                    .animation(
                        .linear(duration: 1.2)
                            .repeatForever(autoreverses: false),
                        value: animate
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .frame(width: 160, height: 236)
        .onAppear { animate = true }
    }
}
