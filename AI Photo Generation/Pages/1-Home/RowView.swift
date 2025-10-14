//
//  RowView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/13/25.
//

import SwiftUI

struct RowView: View {
    let title: String
    let items: [TrendingItem]
    let isVideo: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: TrendingDetailView(item: item)) {
                            VStack(spacing: 8) {
                                if isVideo {
                                    VideoThumbnailView(videoName: item.imageName)
                                        .frame(width: 170, height: 276)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
                                } else {
                                    // Check if this item has scanning animation support
                                    if let originalImage = item.imageNameOriginal {
                                        ScanningImageView(
                                            originalImageName: originalImage,
                                            transformedImageName: item.imageName,
                                            width: 110,
                                            height: 166
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
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
                                    }
                                }

//                                Text(item.title)
//                                    .font(.caption)
//                                    .fontWeight(.medium)
//                                    .lineLimit(2)
//                                    .multilineTextAlignment(.center)
//                                    .frame(width: 140)
//                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
