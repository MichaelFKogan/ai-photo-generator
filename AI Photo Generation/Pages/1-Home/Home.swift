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

struct Home: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Welcome to The AI Photo Generator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Text("Transform your images and create amazing content with AI")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VideoRow(title: "📹 AI Videos", items: videoItems)
                    VideoRow(title: "🧜‍♀️ Mermaid", items: mermaidVideosItems)
                    
                    VideoRow(title: "🎮 Video Game Videos", items: videogamesVideosItems)
//                  VideoRow(title: "Trending", items: trendingItem, diffAnimation: .scanHorizontal)
                    
                    
                    SplitImageRow(title: "Anime", items: animeItems, diffAnimation: .scanHorizontal)
                    SplitImageRow(title: "🦸‍♂️ Action Figures", items: actionfigureItems, diffAnimation: .scanHorizontal)
                    
                    ImageRow(title: "🎲 Random", items: randomItems)
                    SplitImageRow(title: "🎮 Video Game Photos", items: videogamesItems, diffAnimation: .scanHorizontal)
                    
                    SplitImageRow(title: "❤️ Relationships", items: relationshipItems, diffAnimation: .flipCard)
                    
                    SplitImageRow(title: "💫 Futuristic", items: futuristicItems, diffAnimation: .scanHorizontal)
                    SplitImageRow(title: "📸 Photography", items: photographyItems, diffAnimation: .crossfade)
                    
                    SplitImageRow(title: "😂 Pranks", items: prankItems, diffAnimation: .slider)
                    SplitImageRow(title: "❤️ Relationships", items: relationshipItems, diffAnimation: .flipCard)
                    SplitImageRow(title: "🧑‍🧑‍🧒 Family", items: familyItems, diffAnimation: .crossfade)

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
