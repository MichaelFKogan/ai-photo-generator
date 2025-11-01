//
//  HomeView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI
import AVKit

struct InfoPacket: Identifiable {
    let id = UUID()
    let imageName: String
    let imageNameOriginal: String?
    let title: String
    let cost: Double
    let description: String
    
    let prompt: String
    let endpoint: String
    let modelName: String
    let modelDescription: String
    let modelImageName: String
    let exampleImages: [String]
    
    let aspectRatio: String?
    let outputFormat: String
    let enableSyncMode: Bool
    let enableBase64Output: Bool

    // ✅ Default values for flexibility
    init(
        imageName: String,
        imageNameOriginal: String? = nil,
        title: String = "",
        cost: Double = 0.0,
        description: String = "",
        prompt: String = "",
        endpoint: String = "",
        modelName: String = "",
        modelDescription: String = "",
        modelImageName: String = "",
        exampleImages: [String] = [],
        aspectRatio: String? = nil,
        outputFormat: String = "jpeg",
        enableSyncMode: Bool = true,
        enableBase64Output: Bool = false
    ) {
        self.imageName = imageName
        self.imageNameOriginal = imageNameOriginal
        self.title = title
        self.cost = cost
        self.description = description
        self.prompt = prompt
        self.endpoint = endpoint
        self.modelName = modelName
        self.modelDescription = modelDescription
        self.modelImageName = modelImageName
        self.exampleImages = exampleImages
        self.aspectRatio = aspectRatio
        self.outputFormat = outputFormat
        self.enableSyncMode = enableSyncMode
        self.enableBase64Output = enableBase64Output
    }
}




struct Home: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                
//                VStack{
//                    // Title
//                    VStack{
//                            
//                        Text("Unleash Your")
//                            .font(.system(size: 34, weight: .bold, design: .rounded))
//                            .foregroundStyle(
//                                LinearGradient(
//                                    colors: [.blue, .purple],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .tracking(0.3)
//                        
//                        Text("Creativity with AI")
//                            .font(.system(size: 34, weight: .bold, design: .rounded))
//                            .foregroundStyle(
//                                LinearGradient(
//                                    colors: [.blue, .purple],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .tracking(0.3)
//                    }
//                    .multilineTextAlignment(.center)
//                        
//                        // Subtitle
//                        Text("Transform your images and create amazing content with AI")
//                            .font(.body)
//                            .foregroundColor(.secondary)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal)
//                            .lineSpacing(4)
//                }
                
                VStack(spacing: 10) {
                    
                    HomeRowSplit(title: "💯 All", items: allItems, diffAnimation: .scanHorizontal)
                    
                    HomeRowVideo(title: "📈 Trending", items: transformyourphotosItems)
                    HomeRowVideo(title: "💯 Popular", items: funItems)
//                    HomeRowVideo(title: "🎃 Halloween", items: halloweenItems)
                    HomeRowVideo(title: "🎃 Halloween", items: texttovideoItems)
                    
                    HomeRowVideo(title: "For The Girls", items: forthegirlsItems)
//                    HomeRowVideo(title: "For The Guys", items: fortheguysItems)
                    
//                    HomeRowVideo(title: "❤️ Relationships", items: relationshipItems, diffAnimation: .flipCard)
//                    HomeRowVideo(title: "Family", items: fortheguysItems)
                    
                    
//                    HomeRowVideo(title: "🧜‍♀️ Mermaid", items: mermaidVideosItems)
                    
                    HomeRowVideo(title: "🎮 Video Game Videos", items: videogamesVideosItems)
                    
                    HomeRowSplit(title: "🎮 Video Game Photos", items: videogamesItems, diffAnimation: .scanHorizontal)
//                  HomeRowVideo(title: "Trending", items: trendingItem, diffAnimation: .scanHorizontal)
                    
                    
                    HomeRowSplit(title: "Anime", items: animeItems, diffAnimation: .scanHorizontal)
                    HomeRowSplit(title: "🦸‍♂️ Action Figures", items: actionfigureItems, diffAnimation: .scanHorizontal)
                    
                    HomeRowSingle(title: "🎲 Random", items: randomItems)
                    
//                    HomeRowSplit(title: "❤️ Relationships", items: relationshipItems, diffAnimation: .flipCard)
                    
                    HomeRowSplit(title: "💫 Futuristic", items: futuristicItems, diffAnimation: .scanHorizontal)
                    HomeRowSplit(title: "📸 Photography", items: photographyItems, diffAnimation: .crossfade)
                    
                    HomeRowSplit(title: "😂 Pranks", items: prankItems, diffAnimation: .slider)
//                    HomeRowSplit(title: "❤️ Relationships", items: relationshipItems, diffAnimation: .flipCard)
//                    HomeRowSplit(title: "🧑‍🧑‍🧒 Family", items: familyItems, diffAnimation: .crossfade)

                }
            }
//            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Creator AI Studio")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                        )
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 6) {
                        Image(systemName: "diamond.fill")
                            .foregroundStyle(
                                LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .font(.system(size: 8))
                        Text("$5.00")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                        Text("credits left")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.secondary.opacity(0.1)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                    )
                }
            }


//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        themeManager.toggleTheme()
//                    }) {
//                        Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
//                            .foregroundColor(.primary)
//                    }
//                }
//            }
        }
    }
}
