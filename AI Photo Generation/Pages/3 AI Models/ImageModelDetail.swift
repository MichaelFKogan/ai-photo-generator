//
//  ImageModelDetail.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/8/25.
//

import PhotosUI
import SwiftUI

struct ImageModelDetail: View {
    @State var item: InfoPacket

    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var notificationManager: NotificationManager

    @State private var prompt: String = ""
    @State private var negativePrompt: String = ""
    @State private var isGenerating: Bool = false
    @State private var referenceImages: [UIImage] = []
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var selectedAspectIndex: Int = 0 // default to 1:1
    @State private var numImages: Int = 1
    @State private var guidance: Double = 7.5
    @State private var steps: Int = 30
    @State private var isAdvancedOptionsExpanded: Bool = false
    @State private var isExamplePromptsExpanded: Bool = false
    @State private var isModelSelectorPresented: Bool = false
    @State private var lastScrollOffset: CGFloat = 0
    @FocusState private var isPromptFocused: Bool
    @Environment(\.dismiss) private var dismiss

    private let feedback = UISelectionFeedbackGenerator()

    private let imageAspects: [String] = ["1:1", "3:4", "4:3", "9:16", "16:9"]
    private let imageAspectOptions: [AspectRatioOption] = [
        AspectRatioOption(id: "3:4", label: "3:4", width: 3, height: 4, platforms: ["Portrait"]),
        AspectRatioOption(id: "9:16", label: "9:16", width: 9, height: 16, platforms: ["TikTok", "Reels"]),
        AspectRatioOption(id: "1:1", label: "1:1", width: 1, height: 1, platforms: ["Instagram"]),
        AspectRatioOption(id: "4:3", label: "4:3", width: 4, height: 3, platforms: ["Photo Prints"]),
        AspectRatioOption(id: "16:9", label: "16:9", width: 16, height: 9, platforms: ["YouTube"]),
    ]

    private let examplePrompts: [String] = [
        "A serene landscape with mountains at sunset, photorealistic, 8k quality",
        "A futuristic cityscape with flying cars and neon lights at night",
        "A cute fluffy kitten playing with yarn, studio lighting, professional photography",
        "An astronaut riding a horse on the moon, cinematic lighting, detailed",
        "A cozy coffee shop interior with warm lighting and plants, architectural photography",
        "A majestic dragon soaring through clouds, fantasy art, highly detailed",
        "A vintage sports car on an empty road, golden hour lighting, 4k",
        "A magical forest with glowing mushrooms and fireflies, fantasy illustration",
        "A modern minimalist living room with large windows, interior design photography",
        "A colorful abstract painting with geometric shapes and vibrant colors",
        "A medieval castle on a cliff overlooking the ocean, dramatic lighting",
        "A cyberpunk street market with holographic signs, neon colors, ultra detailed",
        "A peaceful zen garden with cherry blossoms and koi pond, soft focus",
        "A powerful lion portrait with intense eyes, wildlife photography, 8k",
        "A steampunk airship in the clouds, brass and copper details, concept art",
        "A tropical beach at sunrise with palm trees, paradise scenery, HDR",
        "An enchanted library with floating books and magical lights, fantasy art",
        "A modern luxury yacht on crystal clear water, professional photography",
        "A mysterious alien landscape with purple sky and twin moons, sci-fi art",
        "A rustic farmhouse in autumn with falling leaves, warm colors, cozy atmosphere",
        "A sleek modern kitchen with marble countertops, architectural digest style",
        "A samurai warrior in traditional armor, dramatic pose, cinematic composition",
        "A vibrant coral reef with tropical fish, underwater photography, vivid colors",
        "A gothic cathedral interior with stained glass windows, divine lighting",
        "A bustling Tokyo street at night with neon signs, street photography",
        "A serene mountain lake reflection at dawn, mirror-like water, pristine nature",
        "A futuristic robot with intricate mechanical details, sci-fi concept art",
        "A cozy reading nook by a window on a rainy day, warm lighting",
        "A majestic phoenix rising from flames, mythical creature, vibrant colors",
        "A Victorian mansion in foggy weather, gothic atmosphere, haunting beauty",
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // MARK: - Banner Image Section

                    // Banner Image at top - extends behind navigation bar
                    ZStack(alignment: .bottom) {
                        Image(item.modelImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height * 0.35)
                            .clipped()

                        // Only gradient behind the text section
                        VStack {
                            Spacer()

                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(item.modelName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)

                                        HStack(spacing: 6) {
                                            Image(systemName: "photo.on.rectangle.angled")
                                                .font(.caption)
                                            Text("Image Generation Model")
                                                .font(.caption)
                                        }
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            Capsule()
                                                .fill(Color.blue.opacity(0.8))
                                        )
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text(String(format: "$%.2f", item.cost))
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black.opacity(0.8))
                                            .cornerRadius(6)

                                        Text("per image")
                                            .font(.caption2)
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 8)

                                // Model Details Card (without image now)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.modelDescription)
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.8))
                                        .lineLimit(4)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 12)
                            .background(
                                LinearGradient(
                                    colors: [Color.black.opacity(0.6), Color.black.opacity(0.05)],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                        }
                    }
                    .frame(height: geometry.size.height * 0.35)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                    VStack(spacing: 24) {
//                        Divider()
//                            .padding(.horizontal)
//                            .padding(.top, 8)

                        // MARK: - Example Images Section

                        // Example Images Section
                        if !item.exampleImages.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "photo.stack")
                                        .foregroundColor(.blue)
                                    Text("Example Results")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(item.exampleImages, id: \.self) { imageName in
                                            Image(imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 160, height: 224)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                )
                                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                                                .accessibilityLabel("Example image generated by \(item.modelName)")
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }

                        // MARK: - Model Selector

                        // Model Selector Button
                        Button(action: {
                            isModelSelectorPresented = true
                        }) {
                            HStack(spacing: 12) {
                                Image(item.modelImageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.modelName)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)

                                    Text(String(format: "$%.2f per image", item.cost))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)

                        // MARK: - Prompt

                        // Prompt
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 6) {
                                Image(systemName: "text.alignleft")
                                    .foregroundColor(.blue)
                                Text("Prompt")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }

                            TextEditor(text: $prompt)
                                .font(.system(size: 14)).opacity(0.8)
                                .frame(minHeight: 140)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isPromptFocused ? Color.blue.opacity(0.5) : Color.gray.opacity(0.3), lineWidth: isPromptFocused ? 2 : 1)
                                )
                                .overlay(alignment: .topLeading) {
                                    if prompt.isEmpty {
                                        Text("Describe the image you want to generate...")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray.opacity(0.5))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 16)
                                            .allowsHitTesting(false)
                                    }
                                }
                                .animation(.easeInOut(duration: 0.2), value: isPromptFocused)
                                .focused($isPromptFocused)
                                .accessibilityLabel("Image generation prompt")
                                .accessibilityHint("Enter a description of the image you want to create")

                            // MARK: - Example Prompts

                            // Example Prompts (dropdown)
                            DisclosureGroup(isExpanded: $isExamplePromptsExpanded) {
                                ScrollView(.vertical, showsIndicators: true) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        ForEach(examplePrompts, id: \.self) { examplePrompt in
                                            Button(action: {
                                                prompt = examplePrompt
                                                isPromptFocused = false
                                                isExamplePromptsExpanded = false
                                            }) {
                                                HStack {
                                                    Text(examplePrompt)
                                                        .font(.system(size: 11))
                                                        .foregroundColor(.primary)
                                                        .multilineTextAlignment(.leading)
                                                        .lineLimit(2)
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                    Image(systemName: "arrow.up.left")
                                                        .font(.system(size: 9))
                                                        .foregroundColor(.blue.opacity(0.6))
                                                }
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 8)
                                                .background(Color.gray.opacity(0.06))
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
                                                )
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .background(ScrollOffsetReader { newOffset in
                                        handleScrollFeedback(newOffset: newOffset)
                                    })
                                }
                                .frame(maxHeight: 150)
                                .padding(.top, 8)
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb.fill")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                    Text("Example Prompts")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.horizontal)

                        //                // Negative Prompt
                        //                VStack(alignment: .leading, spacing: 8) {
                        //                    HStack(spacing: 6) {
                        //                        Image(systemName: "text.badge.minus")
                        //                            .foregroundColor(.secondary)
                        //                        Text("Negative Prompt (Optional)")
                        //                            .font(.headline)
                        //                            .foregroundColor(.secondary)
                        //                    }
                        //
                        //                    TextEditor(text: $negativePrompt)
                        //                        .font(.system(size: 14)).opacity(0.8)
                        //                        .frame(minHeight: 60)
                        //                        .padding(8)
                        //                        .background(Color.gray.opacity(0.1))
                        //                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        //                        .overlay(
                        //                            RoundedRectangle(cornerRadius: 12)
                        //                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        //                        )
                        //                        .overlay(alignment: .topLeading) {
                        //                            if negativePrompt.isEmpty {
                        //                                Text("What to avoid in the image...")
                        //                                    .font(.system(size: 14))
                        //                                    .foregroundColor(.gray.opacity(0.5))
                        //                                    .padding(.horizontal, 12)
                        //                                    .padding(.vertical, 16)
                        //                                    .allowsHitTesting(false)
                        //                            }
                        //                        }
                        //                }
                        //                .padding(.horizontal)

                        // MARK: - Reference Images

                        // Reference Images (Optional) - multi-image picker and grid
                        ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems, color: .blue)
                            .padding(.horizontal)

                        // MARK: - Aspect Ratio

                        // Core Image Options
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 6) {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(.blue)
                                Text("Aspect Ratio")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }

                            VStack(alignment: .leading, spacing: 6) {
//                                Text("Aspect Ratio")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
                                AspectRatioSelector(options: imageAspectOptions, selectedIndex: $selectedAspectIndex, color: .blue)
                            }
                        }
                        .padding(.horizontal)

//                        // Advanced Options (dropdown)
//                        DisclosureGroup("Advanced Options", isExpanded: $isAdvancedOptionsExpanded) {
//                            VStack(alignment: .leading, spacing: 12) {
//                                VStack(alignment: .leading, spacing: 8) {
//                                    HStack {
//                                        Text("Image Count: \(numImages)")
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Spacer()
//                                    }
//                                    Slider(
//                                        value: Binding(get: { Double(numImages) }, set: { numImages = Int($0) }),
//                                        in: 1...4,
//                                        step: 1
//                                    )
//                                }
//
//                                VStack(alignment: .leading, spacing: 8) {
//                                    HStack {
//                                        Text("Guidance: \(String(format: "%.1f", guidance))")
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Spacer()
//                                    }
//                                    Slider(value: $guidance, in: 0...20, step: 0.5)
//                                }
//
//                                VStack(alignment: .leading, spacing: 8) {
//                                    HStack {
//                                        Text("Steps: \(steps)")
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Spacer()
//                                    }
//                                    Slider(
//                                        value: Binding(get: { Double(steps) }, set: { steps = Int($0) }),
//                                        in: 10...60,
//                                        step: 1
//                                    )
//                                }
//                            }
//                            .padding(.top, 8)
//                        }
//                        .padding(.horizontal)

                        // MARK: - Cost Summary Card

                        // Cost Summary Card
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Generation Cost")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 4) {
                                    Text("1 image")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    Text("×")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(String(format: "$%.2f", item.cost))
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                            }

                            Spacer()

                            Text(String(format: "$%.2f", item.cost))
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.08))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        // .padding(.bottom, 12)

                        // MARK: - Generate Button

                        // Generate button
                        Button(action: generate) {
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
                            .background(
                                (isGenerating || prompt.isEmpty) ?
                                    AnyShapeStyle(Color.gray) :
                                    AnyShapeStyle(LinearGradient(
                                        colors: [Color.blue.opacity(0.8), Color.blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: (isGenerating || prompt.isEmpty) ? Color.clear : Color.blue.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .scaleEffect(isGenerating ? 0.98 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isGenerating)
                        .disabled(isGenerating || prompt.isEmpty)
                        .accessibilityLabel(prompt.isEmpty ? "Enter a prompt to generate image" : "Generate image with prompt: \(prompt)")
                        .accessibilityHint(prompt.isEmpty ? "" : "Double tap to start generation")
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                    .padding(.bottom, 80)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isPromptFocused = false
        }
        .sheet(isPresented: $isModelSelectorPresented) {
            ModelSelectorSheet(
                selectedModel: $item,
                isPresented: $isModelSelectorPresented
            )
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isPromptFocused = false
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 6) {
                    Image(systemName: "diamond.fill")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .font(.system(size: 8))
                    Text("$5.00")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    Text("credits left")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.4))
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 1.5
                        )
                )
            }
        }
    }

    private func generate() {
        guard !isGenerating else { return }

        isGenerating = true

        // Get the selected aspect ratio
        let selectedAspectOption = imageAspectOptions[selectedAspectIndex]
        let aspectRatioString = selectedAspectOption.id // e.g., "1:1", "16:9", etc.

        // Create a modified InfoPacket with the custom prompt and aspect ratio
        var modifiedItem = item
        modifiedItem.prompt = prompt
        modifiedItem.aspectRatio = aspectRatioString

        // Use reference image if available, otherwise create a placeholder
        // If user has selected reference images, use the first one for image-to-image generation
        // Otherwise, use a placeholder for text-to-image generation
        let imageToUse: UIImage
        if !referenceImages.isEmpty {
            imageToUse = referenceImages[0]
        } else {
            imageToUse = createPlaceholderImage()
        }

        // Get user ID
        let userId = authViewModel.user?.id.uuidString.lowercased() ?? ""

        // Start background generation using NotificationManager
        let taskId = notificationManager.startBackgroundGeneration(
            item: modifiedItem,
            image: imageToUse,
            userId: userId,
            onImageGenerated: { [weak notificationManager] _ in
                DispatchQueue.main.async {
                    isGenerating = false
                    // Optionally handle the generated image here
                    // For now, the notification system will handle showing the result
                }
            }
        )

        // Note: isGenerating will be set to false in the callback
        // The notification system will show progress and completion
    }

    /// Creates a minimal placeholder image for text-to-image generation
    /// The WaveSpeed API requires an image parameter even for text-to-image
    private func createPlaceholderImage() -> UIImage {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        defer { UIGraphicsEndImageContext() }

        // Create a transparent 1x1 pixel image
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        return image
    }

    private func handleScrollFeedback(newOffset: CGFloat) {
        let delta = abs(newOffset - lastScrollOffset)
        if delta > 40 {
            feedback.selectionChanged()
            lastScrollOffset = newOffset
        }
    }
}

// MARK: - Helper View to detect vertical scroll offset

private struct ScrollOffsetReader: View {
    var onChange: (CGFloat) -> Void

    var body: some View {
        GeometryReader { geo in
            Color.clear
                .preference(key: ScrollOffsetKey.self, value: geo.frame(in: .global).minY)
        }
        .onPreferenceChange(ScrollOffsetKey.self, perform: onChange)
    }
}

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Model Selector Sheet

struct ModelSelectorSheet: View {
    @Binding var selectedModel: InfoPacket
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(imageModelsRow, id: \.modelName) { model in
                        Button(action: {
                            selectedModel = model
                            isPresented = false
                        }) {
                            HStack(spacing: 12) {
                                // Model Image
                                Image(model.modelImageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )

                                // Model Info
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(model.modelName)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)

                                    Text(model.modelDescription)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)

                                    HStack(spacing: 4) {
                                        Image(systemName: "dollarsign.circle.fill")
                                            .font(.caption2)
                                            .foregroundColor(.blue)
                                        Text(String(format: "$%.2f", model.cost))
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(.blue)
                                        Text("per image")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }

                                Spacer()

                                // Selection indicator
                                if model.modelName == selectedModel.modelName {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(model.modelName == selectedModel.modelName ? Color.blue.opacity(0.08) : Color.gray.opacity(0.06))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(model.modelName == selectedModel.modelName ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2), lineWidth: model.modelName == selectedModel.modelName ? 2 : 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Select Model")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
