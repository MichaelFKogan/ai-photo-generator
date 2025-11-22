//
//  HomeRowAIVideoModels.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

import SwiftUI

struct HomeRowAIVideoModels: View {
    let title: String
    let items: [InfoPacket]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RowTitle(title: title) {
                print("Tapped See All for \(title)")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: VideoModelDetail(item: item)) {
                            VStack(spacing: 8) {
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
                                // ✅ Top-right overlay (Price)
//                                    .overlay(alignment: .topTrailing) {
//    //                                        if let price = item.price {
//    //                                            Text("$\(price, specifier: "%.2f")")
//                                        Text("$\(item.cost, specifier: "%.2f")")
//                                                .font(.custom("Nunito-Bold", size: 11))
//                                                .foregroundColor(.white)
//                                                .padding(.horizontal, 6)
//                                                .padding(.vertical, 3)
                                ////                                                .background(Color.black.opacity(0.8))
                                ////                                                .clipShape(Capsule())
//                                                .shadow(color: .black, radius: 2, x: 1, y: 1)
//                                                .padding(6)
//    //                                        }
//                                    }

//                                Text(item.title)
//                                    .font(.custom("Nunito-ExtraBold", size: 11))
//                                    .lineLimit(2)
//                                    .multilineTextAlignment(.center)
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
