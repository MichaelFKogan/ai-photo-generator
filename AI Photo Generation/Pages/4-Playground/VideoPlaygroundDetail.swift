//
//  VideoPlaygroundDetail.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/16/25.
//

import SwiftUI

// MARK: - Video Playground Tab
struct VideoPlaygroundDetail: View {
    @Binding var prompt: String
    @Binding var isGenerating: Bool
    @Binding var referenceImages: [UIImage]
//    @Binding var selectedPhotoItems: [PhotosPickerItem] 
    @Binding var selectedVideoModelId: String
    @Binding var showModelPicker: Bool
    @Binding var videoDurationIndex: Int
    @Binding var videoAspectIndex: Int
    let generateAction: () -> Void

    private let videoDurations: [String] = ["5s", "8s", "12s"]
    private let videoAspects: [String] = ["9:16", "16:9", "1:1"]
    private let videoAspectOptions: [AspectRatioOption] = [
        AspectRatioOption(id: "9:16", label: "9:16", width: 9, height: 16, platforms: ["TikTok", "Shorts", "Reels"]),
        AspectRatioOption(id: "16:9", label: "16:9", width: 16, height: 9, platforms: ["YouTube"]),
        AspectRatioOption(id: "1:1", label: "1:1", width: 1, height: 1, platforms: ["Instagram"])
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // AI Model - header with selector and detail card
                Button {
                    showModelPicker = true
                } label: {
                    VStack(spacing: 12) {
                        Divider()
                        
                        HStack{
                            Image(systemName: "video.fill")
                                .font(.title3)
                            Text("Create Video")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .foregroundColor(.purple)
                        .padding(.bottom, 6)

                        HStack {
                            Image(systemName: "cpu")
                                .foregroundColor(.secondary)
                            Text("AI Model")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("Change")
                                .font(.caption2)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                        }

                        if let model = videoModels.first(where: { $0.modelId == selectedVideoModelId }) {
                            AIModelSection(
                                modelName: model.name,
                                modelDescription: model.description,
                                modelImageName: model.imageName,
                                price: model.price,
                                priceCaption: "Price per 8s video"
                            )
                            .id(selectedVideoModelId)
                        }

                        Divider()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(.isButton)
                .accessibilityHint("Opens the video model picker")

                // Video Prompt
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Image(systemName: "text.alignleft")
                            .foregroundColor(.secondary)
                        Text("Prompt")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }

                    TextEditor(text: $prompt)
                        .font(.system(size: 14)).opacity(0.8)
                        .frame(minHeight: 120)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
//                // Reference Images (Optional) - multi-image picker and grid
//                ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems)
//                    .padding(.horizontal)

                // Simple Video Options
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.secondary)
                        Text("Video Options")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Duration")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Duration", selection: $videoDurationIndex) {
                            ForEach(0..<videoDurations.count, id: \.self) { idx in
                                Text(videoDurations[idx])
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Aspect Ratio")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        AspectRatioSelector(options: videoAspectOptions, selectedIndex: $videoAspectIndex, color: .blue)
                    }
                }
                .padding(.horizontal)

//                // Reference Images (Optional)
//                ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems)
//                    .padding(.horizontal)

                // Generate Video button
                Button(action: generateAction) {
                    HStack {
                        if isGenerating {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Image(systemName: "film")
                        }
                        Text(isGenerating ? "Generating Video..." : "Generate Video")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((isGenerating || prompt.isEmpty) ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(isGenerating || prompt.isEmpty)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top)
            .padding(.bottom, 200)
        }
    }
}
