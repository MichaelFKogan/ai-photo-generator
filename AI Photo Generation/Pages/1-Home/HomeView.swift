//
//  HomeView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI
import AVKit

struct TrendingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let imageNameOriginal: String?
    let title: String
    let description: String
    
    let prompt: String
    let modelName: String
    let modelDescription: String
    let modelImageName: String
    let exampleImages: [String]
    
    init(imageName: String, imageNameOriginal: String? = nil, title: String, description: String, prompt: String, modelName: String, modelDescription: String, modelImageName: String, exampleImages: [String]) {
        self.imageName = imageName
        self.imageNameOriginal = imageNameOriginal
        self.title = title
        self.description = description
        self.prompt = prompt
        self.modelName = modelName
        self.modelDescription = modelDescription
        self.modelImageName = modelImageName
        self.exampleImages = exampleImages
    }
}

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Welcome to AI Photo Generation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Text("Transform your images and create amazing content with AI")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    RowView(title: "📹 AI Videos", items: videoItems, isVideo: true)
//                    RowView(title: "Trending", items: trendingItems, isVideo: false, diffAnimation: .scanHorizontal)
                    
                    RowView(title: "Anime", items: animeItems, isVideo: false, diffAnimation: .scanHorizontal)
                    RowView(title: "🦸‍♂️ Action Figures", items: actionfigureItems, isVideo: false, diffAnimation: .scanHorizontal)
                    RowView(title: "🎲 Random", items: randomItems, isVideo: false)
                    RowView(title: "🎮 Video Games", items: videogamesItems, isVideo: false, diffAnimation: .scanHorizontal)
                    RowView(title: "💫 Futuristic", items: futuristicItems, isVideo: false, diffAnimation: .scanHorizontal)
                    
                    RowView(title: "📸 Photography", items: photographyItems, isVideo: false, diffAnimation: .crossfade)
                    RowView(title: "😂 Pranks", items: prankItems, isVideo: false, diffAnimation: .slider)
                    
                    RowView(title: "❤️ Relationships", items: relationshipItems, isVideo: false, diffAnimation: .flipCard)
                    RowView(title: "🧑‍🧑‍🧒 Family", items: familyItems, isVideo: false, diffAnimation: .crossfade)

                    // Recent Creations stays unique
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Creations")
                            .font(.title2)
                            .fontWeight(.semibold)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                            ForEach(0..<6, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)

                    
                    // Placeholder for recent creations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Creations")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                            ForEach(0..<6, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
//            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        themeManager.toggleTheme()
                    }) {
                        Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct VideoThumbnailView: View {
    let videoName: String
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let player = player {
                VideoPlayer(player: player)
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        player.seek(to: .zero)
                        player.play()
                        player.isMuted = true
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { _ in
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
            } else {
                Color.black.opacity(0.3)
            }
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                player = AVPlayer(url: url)
            } else {
                print("⚠️ Could not find \(videoName).mp4 in bundle")
            }
        }
        .onDisappear {
            player?.pause()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
