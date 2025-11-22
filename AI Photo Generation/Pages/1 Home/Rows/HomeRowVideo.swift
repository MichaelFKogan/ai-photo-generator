import AVKit
import SwiftUI

struct HomeRowVideo: View {
    let title: String
    let items: [InfoPacket]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RowTitle(title: title) {
                print("Tapped See All for \(title)")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                // Tile sizing tuned to match existing portrait aspect
                let tileWidth: CGFloat = 220
                let tileHeight: CGFloat = 300 // slightly shorter row height
                let hSpacing: CGFloat = 12
                let gridSpacing: CGFloat = 8

                HStack(spacing: hSpacing) {
                    ForEach(Array(mosaicBlocks(from: items).enumerated()), id: \.offset) { _, block in
                        switch block {
                        case let .large(item):
                            NavigationLink(destination: VideoDetailView(item: item)) {
                                VideoTile(item: item, width: tileWidth, height: tileHeight)
                            }

                        case let .grid(group):
                            let cellWidth = (tileWidth - gridSpacing) / 2
                            let cellHeight = (tileHeight - gridSpacing) / 2

                            VStack(spacing: gridSpacing) {
                                HStack(spacing: gridSpacing) {
                                    ForEach(0 ..< 2) { col in
                                        let index = col
                                        if index < group.count {
                                            let subItem = group[index]
                                            NavigationLink(destination: VideoDetailView(item: subItem)) {
                                                VideoTile(item: subItem, width: cellWidth, height: cellHeight)
                                            }
                                        } else {
                                            Color.clear.frame(width: cellWidth, height: cellHeight)
                                        }
                                    }
                                }
                                HStack(spacing: gridSpacing) {
                                    ForEach(0 ..< 2) { col in
                                        let index = col + 2
                                        if index < group.count {
                                            let subItem = group[index]
                                            NavigationLink(destination: VideoDetailView(item: subItem)) {
                                                VideoTile(item: subItem, width: cellWidth, height: cellHeight)
                                            }
                                        } else {
                                            Color.clear.frame(width: cellWidth, height: cellHeight)
                                        }
                                    }
                                }
                            }
                            .frame(width: tileWidth, height: tileHeight)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Mosaic building

extension HomeRowVideo {
    private enum MosaicBlock {
        case large(InfoPacket)
        case grid([InfoPacket])
    }

    private func mosaicBlocks(from items: [InfoPacket]) -> [MosaicBlock] {
        var result: [MosaicBlock] = []
        var index = 0
        while index < items.count {
            // Large
            let largeItem = items[index]
            result.append(.large(largeItem))
            index += 1

            // Grid of up to 4
            if index < items.count {
                let end = min(index + 4, items.count)
                let gridItems = Array(items[index ..< end])
                result.append(.grid(gridItems))
                index = end
            }
        }
        return result
    }
}

// MARK: - Reusable video tile

struct VideoTile: View {
    let item: InfoPacket
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            if let url = Bundle.main.url(forResource: item.imageName, withExtension: "mp4") {
                VideoThumbnail(url: url)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
//                    .overlay(alignment: .bottomLeading) {
//                        Text(item.title)
//                            .font(.custom("Nunito-Bold", size: 11))
//                            .lineLimit(2)
//                            .multilineTextAlignment(.leading)
//                            .foregroundColor(.white)
                ////                            .shadow(color: .black.opacity(1), radius: 1, x: 0, y: 1)
//                            .shadow(color: .black, radius: 2, x: 1, y: 1)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(6)
                ////                            .background(
                ////                                LinearGradient(
                ////                                    gradient: Gradient(colors: [
                ////                                        Color.black.opacity(0.6),
                ////                                        Color.black.opacity(0)
                ////                                    ]),
                ////                                    startPoint: .bottom,
                ////                                    endPoint: .top
                ////                                )
                ////                            )
//                    }
//                    .overlay(alignment: .topTrailing) {
//                        Text("$\(item.cost, specifier: "%.2f")")
//                            .font(.custom("Nunito-Bold", size: 11))
//                            .foregroundColor(.white)
//                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                ////                            .padding(.horizontal, 4)
                ////                            .padding(.vertical, 2)
                ////                            .background(Color.black.opacity(0.3))
                ////                            .clipShape(Capsule())
//                            .padding(6)
//                    }
            } else {
                VideoPlaceholder()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
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

    func makeUIView(context _: Context) -> VideoPlayerUIView {
        let view = VideoPlayerUIView()
        view.configure(url: url)
        return view
    }

    func updateUIView(_: VideoPlayerUIView, context _: Context) {}
}

class VideoPlayerUIView: UIView {
    private var playerLayer: AVPlayerLayer?
    private var player: AVQueuePlayer?
    private var statusObserver: NSKeyValueObservation?

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

        // Wait for player to be ready and THEN play
        if let currentItem = player?.currentItem {
            statusObserver = currentItem.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
                if item.status == .readyToPlay {
                    DispatchQueue.main.async {
                        self?.player?.play()
                        // Force a small seek to kickstart rendering
                        self?.player?.seek(to: .zero)
                    }
                } else if item.status == .failed {
                    print("❌ Player item failed:", item.error?.localizedDescription ?? "unknown error")
                }
            }
        } else {
            // If no current item yet, try playing anyway
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.player?.play()
            }
        }

        // Observe app coming to foreground
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func appWillEnterForeground() {
        if player?.currentItem?.status == .readyToPlay {
            player?.play()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }

    deinit {
        statusObserver?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}

class VideoPlayerManager {
    static let shared = VideoPlayerManager()
    private var players: [URL: (player: AVQueuePlayer, looper: AVPlayerLooper)] = [:]

    func player(for url: URL) -> AVQueuePlayer {
        if let existing = players[url] {
            // Make sure it's playing
            existing.player.play()
            return existing.player
        }

        let item = AVPlayerItem(url: url)
        let queue = AVQueuePlayer()

        // IMPORTANT: Wait for item to be ready before creating looper
        let looper = AVPlayerLooper(player: queue, templateItem: item)
        queue.isMuted = true

        // Store before playing
        players[url] = (queue, looper)

        // Don't play here - let the VideoPlayerUIView handle it when ready
        // queue.play()  // REMOVE THIS LINE

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
                                Color.white.opacity(0.0),
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
        .onAppear { animate = true }
    }
}
