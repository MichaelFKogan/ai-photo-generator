//
//  ImagePlaygroundDetail.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/16/25.
//

import SwiftUI

// MARK: - Image Playground Tab
struct ImagePlaygroundDetail: View {
    @Binding var prompt: String
    @Binding var isGenerating: Bool
    @Binding var referenceImages: [UIImage]
//    @Binding var selectedPhotoItems: [PhotosPickerItem]
    @Binding var selectedImageModelId: String
    @Binding var showModelPicker: Bool
    let generateAction: () -> Void

    // Image generation UI-only settings (local state)
    @State private var negativePrompt: String = ""
    @State private var selectedSizeIndex: Int = 1 // default 768x768
    @State private var selectedAspectIndex: Int = 0 // default 1:1
    @State private var numImages: Int = 1
    @State private var guidance: Double = 7.5
    @State private var steps: Int = 30
    @State private var useSeed: Bool = false
    @State private var seedText: String = ""
    @State private var isAdvancedOptionsExpanded: Bool = false

    private let imageSizes: [String] = ["512x512", "768x768", "1024x1024", "512x768", "768x512"]
    private let imageAspects: [String] = ["1:1", "3:4", "4:3", "9:16", "16:9"]
    private let imageAspectOptions: [AspectRatioOption] = [
        AspectRatioOption(id: "1:1", label: "1:1", width: 1, height: 1, platforms: ["Instagram"]),
        AspectRatioOption(id: "3:4", label: "3:4", width: 3, height: 4, platforms: ["Portrait"]),
        AspectRatioOption(id: "4:3", label: "4:3", width: 4, height: 3, platforms: ["Photo Prints"]),
        AspectRatioOption(id: "9:16", label: "9:16", width: 9, height: 16, platforms: ["TikTok", "Reels"]),
        AspectRatioOption(id: "16:9", label: "16:9", width: 16, height: 9, platforms: ["YouTube"])
    ]
    private let imageSizeOptions: [SizeOption] = [
        SizeOption(id: "512x512", label: "512 x 512", widthPx: 512, heightPx: 512),
        SizeOption(id: "768x768", label: "768 x 768", widthPx: 768, heightPx: 768),
        SizeOption(id: "1024x1024", label: "1024 x 1024", widthPx: 1024, heightPx: 1024),
        SizeOption(id: "512x768", label: "512 x 768", widthPx: 512, heightPx: 768),
        SizeOption(id: "768x512", label: "768 x 512", widthPx: 768, heightPx: 512)
    ]
    private let stylePresets: [String] = ["Photorealistic", "Anime", "Illustration", "Digital Art", "Film", "Cinematic", "Sketch"]
    @State private var selectedStyleIndex: Int? = nil
    @State private var enableFaceRestoration: Bool = false
    @State private var enhanceSharpness: Bool = false
    @State private var removeBackground: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // AI Model - header with selector and detail card like TrendingDetailView
                Button {
                    showModelPicker = true
                } label: {
                    VStack(spacing: 12) {
                        Divider()
                        
                        HStack{
                            Image(systemName: "photo.on.rectangle")
                                .font(.title3)
                            Text("Create Image")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .foregroundColor(.blue)
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

                        if let model = imageModels.first(where: { $0.modelId == selectedImageModelId }) {
                            AIModelSection(
                                modelName: model.name,
                                modelDescription: model.description,
                                modelImageName: model.imageName,
                                price: model.price,
                                priceCaption: "Price per image"
                            )
                            .id(selectedImageModelId)
                        }

                        Divider()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(.isButton)
                .accessibilityHint("Opens the image model picker")

                // Prompt - styled like TrendingDetailView's PromptSection
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6){
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

//                // Negative Prompt
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack(spacing: 6){
//                        Image(systemName: "text.badge.minus")
//                            .foregroundColor(.secondary)
//                        Text("Negative Prompt (Optional)")
//                            .font(.headline)
//                            .foregroundColor(.secondary)
//                    }
//
//                    TextEditor(text: $negativePrompt)
//                        .font(.system(size: 14)).opacity(0.8)
//                        .frame(minHeight: 40)
//                        .padding(8)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                        )
//
//                }
//                .padding(.horizontal)

//                // Reference Images (Optional) - multi-image picker and grid
//                ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems)
//                    .padding(.horizontal)

                // Core Image Options
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.secondary)
                        Text("Image Options")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }

//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Size")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                        SizeSelector(options: imageSizeOptions, selectedIndex: $selectedSizeIndex)
//                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Aspect Ratio")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        AspectRatioSelector(options: imageAspectOptions, selectedIndex: $selectedAspectIndex)
                    }
                }
                .padding(.horizontal)

//                // Advanced Options (dropdown)
//                DisclosureGroup("Advanced Options", isExpanded: $isAdvancedOptionsExpanded) {
//                    VStack(alignment: .leading, spacing: 12) {
//                        VStack(alignment: .leading, spacing: 8) {
//                            HStack {
//                                Text("Image Count: \(numImages)")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                                Spacer()
//                            }
//                            Slider(
//                                value: Binding(get: { Double(numImages) }, set: { numImages = Int($0) }),
//                                in: 1...4,
//                                step: 1
//                            )
//                        }
//
//                        VStack(alignment: .leading, spacing: 8) {
//                            HStack {
//                                Text("Guidance: \(String(format: "%.1f", guidance))")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                                Spacer()
//                            }
//                            Slider(value: $guidance, in: 0...20, step: 0.5)
//                        }
//
//                        VStack(alignment: .leading, spacing: 8) {
//                            HStack {
//                                Text("Steps: \(steps)")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                                Spacer()
//                            }
//                            Slider(
//                                value: Binding(get: { Double(steps) }, set: { steps = Int($0) }),
//                                in: 10...60,
//                                step: 1
//                            )
//                        }
//                    }
//                    .padding(.top, 8)
//                }
//                .padding(.horizontal)

                // Generate button (no model count dependency)
                Button(action: generateAction) {
                    HStack {
                        if isGenerating {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Image(systemName: "photo.on.rectangle")
                        }
                        Text(isGenerating ? "Generating..." : "Generate Image")
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
