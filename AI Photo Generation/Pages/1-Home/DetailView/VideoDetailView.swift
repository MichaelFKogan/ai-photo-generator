//
//  VideoDetailView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/16/25.
//

//
//  VideoDetailView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    let item: InfoPacket
    @State private var prompt: String = ""
    @State private var isGenerating: Bool = false
    @State private var createArrowMove: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                AnimatedTitle(text: item.title)
                
                // MARK: - Hero Section (Left static image, Right video)
                DiagonalOverlappingVideos(
                    leftImageName: item.imageNameOriginal ?? item.imageName,
                    rightVideoName: item.imageName // expects an .mp4 file in bundle
                )
                
                HStack(alignment: .center, spacing: 16) {
                    
                    Button(action: {
//                        showPhotoPicker = true
                    }) {
                        HStack{
                            Image(systemName: "plus")
                                .font(.custom("Nunito-ExtraBold", size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.black).opacity(0)
                                .padding(.leading, 10)
                            Spacer()
                            Text("Pick A Photo")
                                .font(.custom("Nunito-ExtraBold", size: 20))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "plus") // Replace with your desired icon
                                .font(.custom("Nunito-ExtraBold", size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                    }
                }
                .padding(.horizontal, 16)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                
                // MARK: - Cost Section
                HStack{
                    Spacer()
                    HStack{
                        Image(systemName: "tag.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        Text("Cost: $\(item.cost)")
                            .font(.custom("Nunito-Bold", size: 16))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                }
                .padding(.trailing, 6)
                
                
                // MARK: - Example Gallery
                if !item.exampleImages.isEmpty {
                    ExampleVideosSection(videos: item.exampleImages)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 150)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            prompt = item.prompt
            createArrowMove = true
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    // Credits Display
                    HStack(spacing: 6) {
                        Image(systemName: "diamond.fill")
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .font(.system(size: 9))
                        
//                            Text("\(userCredits)")
                        Text("$5.00")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                        Text("credits left")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.1))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
//                                .strokeBorder(Color.secondary.opacity(0.2), lineWidth: 1)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                }
            }
        }
    }
}

//
// MARK: - Diagonal Overlapping Videos
//
struct DiagonalOverlappingVideos: View {
    let leftImageName: String
    let rightVideoName: String
    @State private var arrowWiggle: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width * 0.48
            let cardHeight = cardWidth * 1.33
            let arrowYOffset = -cardHeight * 0.15
            
            ZStack {
                // Left image (reference photo)
                Image(leftImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.25), radius: 12, x: -4, y: 4)
                    .rotationEffect(.degrees(-8))
                    .offset(x: -cardWidth * 0.5)
                
                // Right side: looping video
                if let url = Bundle.main.url(forResource: rightVideoName, withExtension: "mp4") {
                    VideoThumbnail(url: url)
                        .frame(width: cardWidth, height: cardHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.25), radius: 12, x: 4, y: 4)
                        .rotationEffect(.degrees(8))
                        .offset(x: cardWidth * 0.5)
                }
                
                // Wiggle arrow
                Image("arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 62, height: 62)
                    .rotationEffect(.degrees(arrowWiggle ? 4 : -4))
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: arrowWiggle)
                    .offset(y: arrowYOffset)
                    .onAppear { arrowWiggle = true }
            }
            .frame(width: geometry.size.width, height: cardHeight * 1.2)
        }
        .frame(height: 280)
    }
}

//
// MARK: - Example Videos Section
//
struct ExampleVideosSection: View {
    let videos: [String] // expects filenames without .mp4
    @State private var selectedIndex: Int = 0
    @State private var showFullScreen = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "play.rectangle.fill")
                    .foregroundColor(.blue)
                Text("Example Gallery")
                    .font(.custom("Nunito-Bold", size: 22))
                Spacer()
            }
            
            Text("See what’s possible with this video style")
                .font(.caption)
                .foregroundColor(.secondary)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 2),
                spacing: 6
            ) {
                ForEach(Array(videos.enumerated()), id: \.element) { index, videoName in
                    if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                        VideoThumbnail(url: url)
                            .frame(height: 260) // taller rectangle
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .onTapGesture {
                                selectedIndex = index
                                showFullScreen = true
                            }
                    }
                }
            }

        }
        .sheet(isPresented: $showFullScreen) {
            FullScreenVideoPlayer(
                videos: videos,
                selectedIndex: selectedIndex,
                isPresented: $showFullScreen
            )
        }
    }
}

//
// MARK: - Full Screen Video Player
//
struct FullScreenVideoPlayer: View {
    let videos: [String]
    let selectedIndex: Int
    @Binding var isPresented: Bool
    @State private var currentIndex: Int
    @State private var player: AVPlayer?
    
    init(videos: [String], selectedIndex: Int, isPresented: Binding<Bool>) {
        self.videos = videos
        self.selectedIndex = selectedIndex
        self._isPresented = isPresented
        self._currentIndex = State(initialValue: selectedIndex)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            TabView(selection: $currentIndex) {
                ForEach(Array(videos.enumerated()), id: \.offset) { index, videoName in
                    if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .aspectRatio(contentMode: .fit)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                    } label: {
                        ZStack {
                            Circle().fill(Color.secondary.opacity(1))
                                .frame(width: 32, height: 32)
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}
