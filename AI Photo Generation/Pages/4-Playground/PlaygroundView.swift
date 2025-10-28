import SwiftUI
import PhotosUI

struct PlaygroundView: View {
    @State private var prompt: String = ""
    @State private var isGenerating: Bool = false
    @State private var referenceImages: [UIImage] = []
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var selectedVideoModelId: String = videoModels.first?.modelId ?? ""
    @State private var selectedImageModelId: String = imageModels.first?.modelId ?? ""
    @State private var showModelPicker: Bool = false
    @State private var selectedTab: Int = 0 // 0 = Video, 1 = Image (default)
    @State private var videoDurationIndex: Int = 1 // default to 8s
    @State private var videoAspectIndex: Int = 0 // default to 9:16
    @State private var refreshKey = UUID()

    private let videoDurations: [String] = ["5s", "8s", "12s"]
    private let videoAspects: [String] = ["9:16", "16:9", "1:1"]

    private var selectedVideoModel: Model? {
        videoModels.first { $0.modelId == selectedVideoModelId }
    }

    private var selectedImageModel: Model? {
        imageModels.first { $0.modelId == selectedImageModelId }
    }

    private var selectedModelBinding: Binding<String> {
        selectedTab == 0 ? $selectedVideoModelId : $selectedImageModelId
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Top Tab Switcher (Video | Image)
                HStack(spacing: 0) {
                    TabHeaderButton(title: "Video", isSelected: selectedTab == 0) {
                        withAnimation { selectedTab = 0 }
                    } label: {
                        Label("Video", systemImage: "video.fill")
                    }

                    TabHeaderButton(title: "Image", isSelected: selectedTab == 1) {
                        withAnimation { selectedTab = 1 }
                    } label: {
                        Label("Image", systemImage: "photo.fill")
                    }
                }
                .padding(.horizontal)

                // Hidden navigation link to present the model picker as a page
                NavigationLink(destination:
                    ModelPickerView(
                        selectedVideoModelId: $selectedVideoModelId,
                        selectedImageModelId: $selectedImageModelId,
                        selectedTab: $selectedTab,
                        refreshKey: $refreshKey
                    ), isActive: $showModelPicker
                ) {
                    EmptyView()
                }
                .hidden()

                TabView(selection: $selectedTab) {
                    VideoPlaygroundTab(
                        prompt: $prompt,
                        isGenerating: $isGenerating,
                        referenceImages: $referenceImages,
                        selectedPhotoItems: $selectedPhotoItems,
                        selectedVideoModelId: $selectedVideoModelId,
                        showModelPicker: $showModelPicker,
                        videoDurationIndex: $videoDurationIndex,
                        videoAspectIndex: $videoAspectIndex,
                        generateAction: generate
                    )
                    .tag(0)

                    ImagePlaygroundTab(
                        prompt: $prompt,
                        isGenerating: $isGenerating,
                        referenceImages: $referenceImages,
                        selectedPhotoItems: $selectedPhotoItems,
                        selectedImageModelId: $selectedImageModelId,
                        showModelPicker: $showModelPicker,
                        generateAction: generate
                    )
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .id(refreshKey)
                
            }
            .padding(.top, 12)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: ModelsView()) {
//                        Image(systemName: "cpu")
//                    }
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Playground")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
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
                                .font(.system(size: 8))
                            
//                            Text("\(userCredits)")
                            Text("$5.00")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
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

    private func generate() {
        isGenerating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isGenerating = false
        }
    }
}

// MARK: - Reference Images Section (Multi-select)
struct ReferenceImagesSection: View {
    @Binding var referenceImages: [UIImage]
    @Binding var selectedPhotoItems: [PhotosPickerItem]

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "photo.on.rectangle")
                    .foregroundColor(.secondary)
                Text("Reference Images (Optional)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            LazyVGrid(columns: columns, spacing: 12) {
                // Existing selected reference images
                ForEach(referenceImages.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: referenceImages[index])
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.6), lineWidth: 1)
                            )

                        Button(action: { referenceImages.remove(at: index) }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.red))
                        }
                        .padding(6)
                    }
                }

                // Add images tile
                PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: 10, matching: .images) {
                    VStack(spacing: 12) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 28))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        VStack(spacing: 4) {
                            Text("Add Images")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                            Text("Up to 10")
                                .font(.caption2)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.03))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(style: StrokeStyle(lineWidth: 3.5, dash: [6, 4]))
                            .foregroundColor(.gray.opacity(0.4))
                    )
                }
                .onChange(of: selectedPhotoItems) { newItems in
                    Task {
                        var newlyAdded: [UIImage] = []
                        for item in newItems {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                newlyAdded.append(image)
                            }
                        }
                        referenceImages.append(contentsOf: newlyAdded)
                        selectedPhotoItems.removeAll()
                    }
                }
            }
        }
    }
}

// MARK: - Visual Selectors (Aspect Ratio & Size)
struct AspectRatioOption: Identifiable {
    let id: String
    let label: String
    let width: CGFloat
    let height: CGFloat
    let platforms: [String]
}

struct SizeOption: Identifiable {
    let id: String
    let label: String
    let widthPx: Int
    let heightPx: Int
}

struct AspectRatioSelector: View {
    let options: [AspectRatioOption]
    @Binding var selectedIndex: Int

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(options.indices, id: \.self) { idx in
                let option = options[idx]
                let isSelected = idx == selectedIndex
                Button {
                    selectedIndex = idx
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.08))
                            // Preview shape maintaining aspect ratio
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.5), lineWidth: isSelected ? 2 : 1)
                                .aspectRatio(option.width / option.height, contentMode: .fit)
                                .frame(height: 36)
                                .padding(8)
                        }
                        .frame(height: 60)

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(option.label)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                if isSelected {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.caption2)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal, 5)

                            // Platform recommendations (first 1 shown)
                            if !option.platforms.isEmpty {
                                HStack(spacing: 4) {
                                    ForEach(option.platforms.prefix(1), id: \.self) { platform in
                                        Text(platform)
                                            .font(.caption2)
                                            .foregroundColor(.blue)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 2)
                                            .background(Color.blue.opacity(0.12))
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                        .padding(.bottom, 6)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct SizeSelector: View {
    let options: [SizeOption]
    @Binding var selectedIndex: Int

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    private func aspectRatio(for option: SizeOption) -> CGFloat {
        guard option.heightPx != 0 else { return 1 }
        return CGFloat(option.widthPx) / CGFloat(option.heightPx)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(options.indices, id: \.self) { idx in
                let option = options[idx]
                let isSelected = idx == selectedIndex
                Button {
                    selectedIndex = idx
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.08))
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.5), lineWidth: isSelected ? 2 : 1)
                                .aspectRatio(aspectRatio(for: option), contentMode: .fit)
                                .frame(height: 56)
                                .padding(12)
                        }
                        .frame(height: 86)

                        HStack(spacing: 6) {
                            Text(option.label)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Video Playground Tab
struct VideoPlaygroundTab: View {
    @Binding var prompt: String
    @Binding var isGenerating: Bool
    @Binding var referenceImages: [UIImage]
    @Binding var selectedPhotoItems: [PhotosPickerItem]
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
                                .font(.title2)
                            Text("Create Video")
                                .font(.title2)
                                .fontWeight(.bold)
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
                
                // Reference Images (Optional) - multi-image picker and grid
                ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems)
                    .padding(.horizontal)

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
                        AspectRatioSelector(options: videoAspectOptions, selectedIndex: $videoAspectIndex)
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

// MARK: - Image Playground Tab
struct ImagePlaygroundTab: View {
    @Binding var prompt: String
    @Binding var isGenerating: Bool
    @Binding var referenceImages: [UIImage]
    @Binding var selectedPhotoItems: [PhotosPickerItem]
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
                                .font(.title2)
                            Text("Create Image")
                                .font(.title2)
                                .fontWeight(.bold)
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

                // Negative Prompt
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6){
                        Image(systemName: "text.badge.minus")
                            .foregroundColor(.secondary)
                        Text("Negative Prompt (Optional)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }

                    TextEditor(text: $negativePrompt)
                        .font(.system(size: 14)).opacity(0.8)
                        .frame(minHeight: 40)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                // Reference Images (Optional) - multi-image picker and grid
                ReferenceImagesSection(referenceImages: $referenceImages, selectedPhotoItems: $selectedPhotoItems)
                    .padding(.horizontal)

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

                // Advanced Options (dropdown)
                DisclosureGroup("Advanced Options", isExpanded: $isAdvancedOptionsExpanded) {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Image Count: \(numImages)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            Slider(
                                value: Binding(get: { Double(numImages) }, set: { numImages = Int($0) }),
                                in: 1...4,
                                step: 1
                            )
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Guidance: \(String(format: "%.1f", guidance))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            Slider(value: $guidance, in: 0...20, step: 0.5)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Steps: \(steps)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            Slider(
                                value: Binding(get: { Double(steps) }, set: { steps = Int($0) }),
                                in: 10...60,
                                step: 1
                            )
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)

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

// MARK: - Model Picker Sheet with Tabs
// Reusable pill-style button used for secondary filters
struct PillButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : .blue)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.12))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : Color.blue.opacity(0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

struct CapabilityPill: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.trailing, 4)
            .foregroundColor(.blue)
//            .background(Color.blue)
//            .clipShape(Capsule())
    }
}

struct ModelPickerView: View {
    @Binding var selectedVideoModelId: String
    @Binding var selectedImageModelId: String
    @Binding var selectedTab: Int // 0 = Video, 1 = Image
    @Environment(\.dismiss) private var dismiss
    @State private var sortOrder = 0 // 0 = Default, 1 = Low->High, 2 = High->Low
    @Binding var refreshKey: UUID
    @State private var videoFilterIndex: Int = 0 // 0 = All, 1 = Text to Video, 2 = Image to Video
    @State private var imageFilterIndex: Int = 0 // 0 = All, 1 = Text to Image, 2 = Image to Image

    private var sortedVideoModels: [Model] {
        switch sortOrder {
        case 1: return videoModels.sorted { $0.price < $1.price }
        case 2: return videoModels.sorted { $0.price > $1.price }
        default: return videoModels
        }
    }

    private var sortedImageModels: [Model] {
        switch sortOrder {
        case 1: return imageModels.sorted { $0.price < $1.price }
        case 2: return imageModels.sorted { $0.price > $1.price }
        default: return imageModels
        }
    }

    private var sortOrderText: String {
        switch sortOrder {
        case 1: return "Low to High"
        case 2: return "High to Low"
        default: return "Default"
        }
    }

    private var priceCaption: String {
        selectedTab == 0 ? "Price per 8s video" : "Price per image"
    }

    // Dummy capability logic for previewing UI pills
    private func videoCapabilities(for model: Model) -> [String] {
        let sum = model.modelId.unicodeScalars.map { Int($0.value) }.reduce(0, +)
        var caps: [String] = []
        if sum % 2 == 0 { caps.append("Text to Video") }
        if sum % 3 == 0 { caps.append("Image to Video") }
        if sum % 5 == 0 { caps.append("Audio") }
        if caps.isEmpty { caps = ["Text to Video"] }
        return caps
    }

    private func imageCapabilities(for model: Model) -> [String] {
        let sum = model.modelId.unicodeScalars.map { Int($0.value) }.reduce(0, +)
        var caps: [String] = []
        if sum % 2 == 0 { caps.append("Text to Image") }
        if sum % 3 == 0 { caps.append("Image to Image") }
        if caps.isEmpty { caps = ["Text to Image"] }
        return caps
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top Tab Switcher (Video | Image)
            HStack(spacing: 0) {
                TabHeaderButton(title: "Video", isSelected: selectedTab == 0) {
                    withAnimation { selectedTab = 0 }
                } label: {
                    Label("Video", systemImage: "video.fill")
                }

                TabHeaderButton(title: "Image", isSelected: selectedTab == 1) {
                    withAnimation { selectedTab = 1 }
                } label: {
                    Label("Image", systemImage: "photo.fill")
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)


            // Secondary Filters (pills/buttons for layout only)
            if selectedTab == 0 {
                HStack(spacing: 8) {
                    PillButton(title: "All", isSelected: videoFilterIndex == 0) {
                        withAnimation { videoFilterIndex = 0 }
                    }
                    PillButton(title: "Text to Video", isSelected: videoFilterIndex == 1) {
                        withAnimation { videoFilterIndex = 1 }
                    }
                    PillButton(title: "Image to Video", isSelected: videoFilterIndex == 2) {
                        withAnimation { videoFilterIndex = 2 }
                    }
                    PillButton(title: "Audio", isSelected: videoFilterIndex == 3) {
                        withAnimation { videoFilterIndex = 3 }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                HStack(spacing: 8) {
                    PillButton(title: "All", isSelected: imageFilterIndex == 0) {
                        withAnimation { imageFilterIndex = 0 }
                    }
                    PillButton(title: "Text to Image", isSelected: imageFilterIndex == 1) {
                        withAnimation { imageFilterIndex = 1 }
                    }
                    PillButton(title: "Image to Image", isSelected: imageFilterIndex == 2) {
                        withAnimation { imageFilterIndex = 2 }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // Swipeable Content
            TabView(selection: $selectedTab) {
                // Video tab
                ScrollView {
                    HStack{
                        Spacer()
                        Text(priceCaption)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    .padding(.top,2)
                    .padding(.bottom, -4)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(sortedVideoModels) { model in
                            Button {
                                selectedVideoModelId = model.modelId
                                selectedTab = 0
                                refreshKey = UUID()
                                dismiss()
                            } label: {
                                HStack(alignment: .top, spacing: 12) {
                                    Image(model.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(alignment: .top) {
                                            Text(model.name)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.primary)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)

                                            Spacer()

                                            Text(String(format: "$%.2f", model.price))
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.black)
                                                .cornerRadius(6)
                                        }

                                        Text(model.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.leading)

                                        HStack(spacing: 6) {
                                            ForEach(videoCapabilities(for: model), id: \.self) { cap in
                                                CapabilityPill(title: cap)
                                            }
                                        }
                                    }
                                }
                                .padding(12)
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .overlay {
                                    if selectedVideoModelId == model.modelId {
                                        ZStack(alignment: .topTrailing) {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.blue, lineWidth: 2)
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.blue)
                                                .background(Circle().fill(Color.white))
                                                .offset(x: -6, y: 6)
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
//                    .padding(.bottom, 24)
                    .padding(.bottom, 200)
                }
                .tag(0)

                // Image tab
                ScrollView {
                    HStack{
                        Spacer()
                        Text(priceCaption)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    .padding(.top,2)
                    .padding(.bottom, -4)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(sortedImageModels) { model in
                            Button {
                                selectedImageModelId = model.modelId
                                selectedTab = 1
                                refreshKey = UUID()
                                dismiss()
                            } label: {
                                HStack(alignment: .top, spacing: 12) {
                                    Image(model.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(alignment: .top) {
                                            Text(model.name)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.primary)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)

                                            Spacer()

                                            Text(String(format: "$%.2f", model.price))
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.black)
                                                .cornerRadius(6)
                                        }

                                        Text(model.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .multilineTextAlignment(.leading)

                                        HStack(spacing: 6) {
                                            ForEach(imageCapabilities(for: model), id: \.self) { cap in
                                                CapabilityPill(title: cap)
                                            }
                                        }
                                    }
                                }
                                .padding(12)
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .overlay {
                                    if selectedImageModelId == model.modelId {
                                        ZStack(alignment: .topTrailing) {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.blue, lineWidth: 2)
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.blue)
                                                .background(Circle().fill(Color.white))
                                                .offset(x: -6, y: 6)
                                        }
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
//                    .padding(.bottom, 24)
                    .padding(.bottom, 200)
                }
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationTitle("Select Model")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    // Sort options moved here
                    Button {
                        withAnimation { sortOrder = 0 }
                    } label: {
                        Label("Default", systemImage: sortOrder == 0 ? "checkmark" : "")
                    }

                    Button {
                        withAnimation { sortOrder = 1 }
                    } label: {
                        Label("Price Low to High", systemImage: sortOrder == 1 ? "checkmark" : "")
                    }

                    Button {
                        withAnimation { sortOrder = 2 }
                    } label: {
                        Label("Price High to Low", systemImage: sortOrder == 2 ? "checkmark" : "")
                    }
                } label: {
                    HStack{
                        Text("Sort by price")
                            .font(.caption)
                        Image(systemName: "line.3.horizontal.decrease")
                            .accessibilityLabel("Filter")
                    }
                }
            }
        }
    }
}
