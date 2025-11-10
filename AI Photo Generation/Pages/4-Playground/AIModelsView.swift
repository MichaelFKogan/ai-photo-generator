//
//  AIModelsView.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

import SwiftUI

//
//  AIModelsView.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

import SwiftUI

struct AIModelsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - Main Grid
                HStack(alignment: .top, spacing: 16) {
                    // LEFT COLUMN — Video Models
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(videoModelsRow) { item in
                            NavigationLink(destination: AIVideoDetailView(item: item)) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Image(item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 180)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
                                        .overlay(alignment: .topTrailing) {
                                            Text("$\(item.cost, specifier: "%.2f")")
                                                .font(.custom("Nunito-Bold", size: 11))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 3)
                                                .background(Color.black.opacity(0.6))
                                                .clipShape(Capsule())
                                                .padding(6)
                                        }

                                    Text(item.title)
                                        .font(.custom("Nunito-ExtraBold", size: 13))
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .layoutPriority(1)

                    // RIGHT COLUMN — Image Models
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(imageModelsRow) { item in
                            NavigationLink(destination: AIImageDetailView(item: item)) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Image(item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 180)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
                                        .overlay(alignment: .topTrailing) {
                                            Text("$\(item.cost, specifier: "%.2f")")
                                                .font(.custom("Nunito-Bold", size: 11))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 3)
                                                .background(Color.black.opacity(0.6))
                                                .clipShape(Capsule())
                                                .padding(6)
                                        }

                                    Text(item.title)
                                        .font(.custom("Nunito-ExtraBold", size: 13))
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .layoutPriority(1)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("AI Models")
    }
}
