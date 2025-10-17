//
//  RowView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/13/25.
//

import SwiftUI
import AVKit

struct RowView: View {
    let title: String
    let items: [TrendingItem]
    let isVideo: Bool
    var diffAnimation: ImageDiffAnimation? = nil
    
    init(title: String, items: [TrendingItem], isVideo: Bool, diffAnimation: ImageDiffAnimation? = nil) {
        self.title = title
        self.items = items
        self.isVideo = isVideo
        self.diffAnimation = diffAnimation
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack{
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
                                } else {
                                    
                                    // Show diff between original and transformed when available
                                    if let originalImage = item.imageNameOriginal {
                                        if let diffAnimation = diffAnimation {
                                            ImageAnimations(
                                                originalImageName: originalImage,
                                                transformedImageName: item.imageName,
                                                width: 140,
                                                height: 196,
                                                animation: diffAnimation
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 18))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                            )
                                            .overlay(alignment: .bottom) {
                                                Text("Try This")
                                                    .font(.custom("Nunito-ExtraBold", size: 12))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 8)
                                                    .padding(.vertical, 5)
                                                    .background(Color.black.opacity(0.6))
                                                    .clipShape(Capsule())
                                                    .padding(.bottom, 6)
                                            }
                                        } else {
                                            Image(item.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 140, height: 196)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                )
                                                .overlay(alignment: .bottom) {
                                                    Text("Try This")
                                                        .font(.custom("Nunito-ExtraBold", size: 12))
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 5)
                                                        .background(Color.black.opacity(0.6))
                                                        .clipShape(Capsule())
                                                        .padding(.bottom, 6)
                                                }
                                        }
                                    } else {
                                        Image(item.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 140, height: 196)
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                            )
                                            .overlay(alignment: .bottom) {
                                                Text("Try This")
                                                    .font(.custom("Nunito-ExtraBold", size: 12))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 8)
                                                    .padding(.vertical, 5)
                                                    .background(Color.black.opacity(0.6))
                                                    .clipShape(Capsule())
                                                    .padding(.bottom, 6)
                                            }
                                    }
                                }

                                Text(item.title)
                                    .font(.custom("Nunito-ExtraBold", size: 11))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
//                                    .frame(width: 140)
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
