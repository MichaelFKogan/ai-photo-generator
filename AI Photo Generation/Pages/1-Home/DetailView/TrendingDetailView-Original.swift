////
////  TrendingDetailView.swift
////  AI Photo Generation
////
////  Created by Mike K on 10/10/25.
////
//
//import SwiftUI
//import PhotosUI
//
//struct TrendingDetailView: View {
//    let item: TrendingItem
//    @State private var prompt: String = ""
//    @State private var isGenerating: Bool = false
//    @State private var selectedImage: UIImage?
//    @State private var selectedPhotoItem: PhotosPickerItem?
//    @State private var showCamera: Bool = false
//    @State private var showPhotoPicker: Bool = false // <-- new state
//    @State private var createArrowMove: Bool = false
//
//    var body: some View {
//        ScrollView {
//            // Main content with cards
//            VStack(spacing: 20) {
//                
//                AnimatedTitle(text: item.title)
//                
//                // Hero Images Section - Two overlapping diagonal images
//                DiagonalOverlappingImages(
//                    leftImageName: item.imageNameOriginal ?? item.imageName,
//                    rightImageName: item.imageName
//                )
//                .padding(.top, 10)
//                
//                // Card 1: Photo Upload Section
//                VStack(alignment: .leading) {
////                    HStack {
////                        Image(systemName: "photo.badge.plus")
////                            .foregroundColor(.blue)
////                        Text("Step 1: Add Your Photo")
////                            .font(.headline)
////                            .foregroundColor(.primary)
////                        Spacer()
////                    }
////
////                    Text("Upload or take a photo to transform")
////                        .font(.caption)
////                        .foregroundColor(.secondary)
//                    
//                        // Horizontal layout: Add photo box on the left, Create button on the right
//                        // Compute inner width based on page padding (24 + 24)
//                        let pageInnerWidth = UIScreen.main.bounds.width - 48
//                        let addPhotoWidth = pageInnerWidth * 0.48
//                        let createButtonWidth = pageInnerWidth - addPhotoWidth - 16 // account for spacing
//                        let controlHeight: CGFloat = 250
//
//                    HStack(alignment: .center, spacing: 16) {
//                        
//                        Button(action: {
//                            // Action goes here
//                        }) {
//                            HStack{
//                                Image(systemName: "plus")
//                                    .font(.custom("Nunito-ExtraBold", size: 22))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black).opacity(0)
//                                    .padding(.leading, 10)
//                                Spacer()
//                                Text("Pick A Photo")
//                                    .font(.custom("Nunito-ExtraBold", size: 20))
//                                    .foregroundColor(.black)
//                                Spacer()
//                                Image(systemName: "plus") // Replace with your desired icon
//                                    .font(.custom("Nunito-ExtraBold", size: 22))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black)
//                                    .padding(.trailing, 10)
//                                
//                            }
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.white)
//                            .foregroundColor(.black)
//                            .cornerRadius(22)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 22)
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
//                            
//                        }
//                        
////                        AddPhotoButton(
////                            selectedImage: $selectedImage,
////                            selectedPhotoItem: $selectedPhotoItem,
////                            showCamera: $showCamera,
////                            showPhotoPicker: $showPhotoPicker
////                        )
////                        .frame(width: addPhotoWidth, height: controlHeight)
//                        
////                        // Create button placed to the right and sized to match the photo box height
////                        Button(action: {
////                            // Simulate transform action
////                            isGenerating = true
////                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                                isGenerating = false
////                            }
////                        }) {
////                            VStack {
////                                Spacer()
////                                HStack(spacing: 10) {
////                                    Text(isGenerating ? "✨ Creating..." : "🪄 Create")
////                                        .font(.custom("Nunito-Bold", size: 18))
////                                    //                                            .font(.headline)
////                                    //                                            .fontWeight(.semibold)
////                                        .multilineTextAlignment(.center)
////
////                                    Image(systemName: "arrow.right")
////                                        .font(.system(size: 18, weight: .semibold))
////                                    // subtle left-right motion
////                                        .offset(x: createArrowMove ? 6 : -6)
////                                        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: createArrowMove)
////                                }
////                                Spacer()
////                            }
////                            .frame(maxWidth: .infinity)
////                            .foregroundColor(.white)
////                        }
////                        .frame(width: createButtonWidth, height: controlHeight)
////                        .background(
////                            Group {
////                                if isGenerating || selectedImage == nil {
////                                    Color.gray.opacity(0.5)
////                                } else {
////                                    LinearGradient(
////                                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.85)]),
////                                        startPoint: .top,
////                                        endPoint: .bottom
////                                    )
////                                }
////                            }
////                        )
////                        .clipShape(RoundedRectangle(cornerRadius: 10))
////                        .shadow(color: (isGenerating || selectedImage == nil) ? Color.clear : Color.blue.opacity(0.25), radius: 8, x: 0, y: 4)
////                        .disabled(isGenerating || selectedImage == nil)
////                        .animation(.easeInOut(duration: 0.2), value: isGenerating)
//                        
//                        
//                    }
//                    .padding(.horizontal, 16)
//                    .cornerRadius(16)
////                    .background(
////                        // 👇 Add your background color here
////                        RoundedRectangle(cornerRadius: 16)
////                            .fill(Color(.systemGray6)) // You can change this to any color
////                    )
//                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//                    
//                    // Price pill: subtle, non-bright tint with tag icon
//                    HStack{
//                        Spacer()
//                        Image(systemName: "tag.fill")
//                            .font(.system(size: 11, weight: .semibold))
//                            .foregroundColor(Color(UIColor.systemGray))
//
//                        Text("Cost: $0.04")
//                            .font(.custom("Nunito-ExtraBold", size: 16))
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.trailing, 16)
//                    .padding(.top, 2)
////                    .background(
////                        RoundedRectangle(cornerRadius: 12)
////                            .fill(Color(UIColor.systemGray5))
////                    )
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 12)
////                            .stroke(Color(UIColor.systemGray4), lineWidth: 0.5)
////                    )
//                }
//                
//                
//                
//                
//                
//                
////                    // Card 2: Prompt Section
////                    VStack(alignment: .leading, spacing: 12) {
////                        HStack {
////                            Image(systemName: "text.bubble")
////                                .foregroundColor(.purple)
////                            Text("Step 2: Customize Your Prompt")
////                                .font(.headline)
////                                .foregroundColor(.primary)
////                            Spacer()
////                        }
////
////                        Text("Describe how you want to transform your image")
////                            .font(.caption)
////                            .foregroundColor(.secondary)
////
////                        TextEditor(text: $prompt)
////                            .font(.system(size: 15))
////                            .frame(minHeight: 100)
////                            .padding(12)
////                            .background(Color(UIColor.systemBackground))
////                            .cornerRadius(12)
////                            .overlay(
////                                RoundedRectangle(cornerRadius: 12)
////                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
////                            )
////                    }
////                    .padding(16)
////                    .background(Color(UIColor.secondarySystemGroupedBackground))
////                    .cornerRadius(16)
////                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
//                
//                // Card 3: Generate Button
////                VStack(spacing: 12) {
////                    HStack {
////                        Image(systemName: "sparkles")
////                            .foregroundColor(.orange)
////                        Text("Step 2: Generate Your Image")
////                            .font(.headline)
////                            .foregroundColor(.primary)
////                        Spacer()
////                    }
//                    
////                    GenerateButton(
////                        isGenerating: $isGenerating,
////                        selectedImage: selectedImage,
////                        prompt: prompt
////                    )
////                }
//                
//                // Example Images Section
//                if !item.exampleImages.isEmpty {
//                    ExampleImagesSection(images: item.exampleImages)
////                        .padding(.top, 8)
//                }
//            }
//            .padding(.horizontal, 24)
//            .padding(.bottom, 32)
//            .padding(.bottom, 150)
//        }
////        .ignoresSafeArea(edges: .top)
//        .navigationTitle("")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            // Top-right credits left + price indicator (muted styling)
//            ToolbarItem(placement: .navigationBarTrailing) {
//                HStack(spacing: 10) {
//                    // Credits left: bolt icon + amount + small caption
//                    HStack(spacing: 8) {
//                        Image(systemName: "bolt.fill")
//                            .font(.system(size: 10, weight: .semibold))
//                            .foregroundColor(.yellow)
//
//
//                            Text("$5.00")
//                            .font(.system(size: 12, weight: .semibold))
//                                .foregroundColor(.primary)
//                            Text("credits left")
//                                .font(.caption2)
//                                .foregroundColor(.secondary)
//
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 6)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color(UIColor.secondarySystemBackground))
//                    )
//                }
//            }
//        }
//        .sheet(isPresented: $showCamera) {
//            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
//        }
//        .onChange(of: selectedPhotoItem) { newItem in
//            Task {
//                if let data = try? await newItem?.loadTransferable(type: Data.self),
//                   let uiImage = UIImage(data: data) {
//                    selectedImage = uiImage
//                }
//            }
//        }
//        .onAppear {
//            prompt = item.prompt
//            // kick off the subtle arrow motion next to the Create text
//            createArrowMove = true
//        }
//    }
//}
//
//// MARK: - Add Photo Button
//struct AddPhotoButton: View {
//    @Binding var selectedImage: UIImage?
//    @Binding var selectedPhotoItem: PhotosPickerItem?
//    @Binding var showCamera: Bool
//    @Binding var showPhotoPicker: Bool
//    
//    @State private var wiggle: Bool = false
//    
//    var body: some View {
//        if let selectedImage = selectedImage {
//            // Show selected image with remove button
//            ZStack(alignment: .topTrailing) {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(maxWidth: .infinity, maxHeight: 250)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(Color.blue, lineWidth: 2)
//                    )
//                
//                Button(action: { self.selectedImage = nil }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title3)
//                        .foregroundColor(.white)
//                        .background(Circle().fill(Color.red))
//                }
//                .padding(6)
//            }
//        } else {
//            // Show "Add A Photo" button - directly opens photo picker
//            Button(action: { showPhotoPicker = true }) {
//                VStack(spacing: 16) {
//                    // Icon with plus badge
//                    ZStack(alignment: .bottomTrailing) {
//                        Image(systemName: "photo.badge.plus")
//                            .font(.system(size: 50))
//                            .foregroundColor(.gray.opacity(0.4))
//                    }
//                    
//                    VStack(spacing: 4) {
//                        Text("Add A Photo")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                            .foregroundColor(.gray)
//                        
//                        Text("Tap to upload or take")
//                            .font(.caption2)
//                            .foregroundColor(.gray.opacity(0.7))
//                    }
//                }
//                .frame(height: 250)
//                .frame(maxWidth: .infinity, maxHeight: 250)
//                .background(Color.gray.opacity(0.03))
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .strokeBorder(style: StrokeStyle(lineWidth: 3.5, dash: [6, 4]))
//                        .foregroundColor(.gray.opacity(0.4))
//                )
//            }
//            .rotationEffect(.degrees(wiggle ? 2.2 : -2.2))
//            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: wiggle)
//            .onAppear { wiggle = true }
//            .photosPicker(
//                isPresented: $showPhotoPicker,
//                selection: $selectedPhotoItem,
//                matching: .images
//            )
//            .onChange(of: selectedPhotoItem) { newItem in
//                Task {
//                    if let data = try? await newItem?.loadTransferable(type: Data.self),
//                       let uiImage = UIImage(data: data) {
//                        selectedImage = uiImage
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Photo Upload Section
//struct PhotoUploadSection: View {
//    @Binding var selectedImage: UIImage?
//    @Binding var showCamera: Bool
//    @Binding var showPhotoPicker: Bool
//
//    @State private var selectedPhotoItem: PhotosPickerItem?
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Upload or Take Photo")
//                .font(.headline)
//                .foregroundColor(.secondary)
//
//            if let selectedImage = selectedImage {
//                ZStack(alignment: .topTrailing) {
//                    Image(uiImage: selectedImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(height: 200)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.blue, lineWidth: 2)
//                        )
//
//                    Button(action: { self.selectedImage = nil }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .background(Circle().fill(Color.red))
//                    }
//                    .padding(8)
//                }
//            } else {
//                HStack(spacing: 12) {
//                    // Camera Button
//                    Button(action: { showCamera = true }) {
//                        VStack(spacing: 6) {
//                            Image(systemName: "camera")
//                                .font(.system(size: 24))
//                            Text("Take Photo")
//                                .font(.caption2)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 80)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                    }
//
//                    // Photo Library Button
//                    Button(action: { showPhotoPicker = true }) {
//                        VStack(spacing: 6) {
//                            Image(systemName: "photo.on.rectangle.angled")
//                                .font(.system(size: 24))
//                            Text("Choose Photo")
//                                .font(.caption2)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 80)
//                        .background(Color.gray.opacity(0.1))
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                    }
//                    .photosPicker(
//                        isPresented: $showPhotoPicker,
//                        selection: $selectedPhotoItem,
//                        matching: .images
//                    )
//                    .onChange(of: selectedPhotoItem) { newItem in
//                        Task {
//                            if let data = try? await newItem?.loadTransferable(type: Data.self),
//                               let uiImage = UIImage(data: data) {
//                                selectedImage = uiImage
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - AI Model Section
//struct AIModelSection: View {
//    let modelName: String
//    let modelDescription: String
//    let modelImageName: String
//    let price: Double?
//    let priceCaption: String?
//
//    init(
//        modelName: String,
//        modelDescription: String,
//        modelImageName: String,
//        price: Double? = nil,
//        priceCaption: String? = nil
//    ) {
//        self.modelName = modelName
//        self.modelDescription = modelDescription
//        self.modelImageName = modelImageName
//        self.price = price
//        self.priceCaption = priceCaption
//    }
//
//    var body: some View {
//        VStack(spacing: 12) {
//            
////            HStack{
////                Spacer()
////                // Optional price caption (e.g., "Price per 8s video" or "Price per image")
////                if let priceCaption = priceCaption {
////                    HStack {
////                        Spacer()
////                        Text(priceCaption)
////                            .font(.caption)
////                            .foregroundColor(.secondary)
////                    }
////                }
////            }
//
//            HStack(alignment: .top) {
//                // Model Image on the left
//                Image(modelImageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 100, height: 100)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                
//                // Model name and description on the right
//                VStack(alignment: .leading, spacing: 6) {
//                    
//                    HStack(alignment: .top) {
//                        Text(modelName)
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.primary)
//                            .lineLimit(2)
//                            .multilineTextAlignment(.leading)
//                        
//                        Spacer()
//                        
//                        // Optional price badge on the trailing side
//                        if let price = price {
//                            Text(String(format: "$%.2f", price))
//                                .font(.caption)
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 4)
//                                .background(Color.black)
//                                .cornerRadius(6)
//                        }
//                    }
//                    
//                    Text(modelDescription)
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                        .lineLimit(3)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .multilineTextAlignment(.leading)
//                }
//                
//                Spacer()
//            }
//            .padding(12)
//            .background(Color(UIColor.secondarySystemGroupedBackground))
//            .cornerRadius(12)
//            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
//        }
//    }
//}
//
//// MARK: - Prompt Section
//struct PromptSection: View {
//    @Binding var prompt: String
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Prompt")
//                .font(.headline)
//                .foregroundColor(.secondary)
//
//            TextEditor(text: $prompt)
//                .font(.system(size: 14)).opacity(0.8)
//                .frame(minHeight: 120)
//                .padding(8)
//                .background(Color.gray.opacity(0.1))
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                )
//        }
//    }
//}
//
//// MARK: - Generate Button
//struct GenerateButton: View {
//    @Binding var isGenerating: Bool
//    let selectedImage: UIImage?
//    let prompt: String
//    
//    private var isDisabled: Bool {
//        isGenerating || selectedImage == nil || prompt.isEmpty
//    }
//
//    var body: some View {
//        Button(action: {
//            isGenerating = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                isGenerating = false
//            }
//        }) {
//            HStack(spacing: 12) {
//                if isGenerating {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                        .scaleEffect(0.9)
//                } else {
//                    Image(systemName: "photo.on.rectangle")
//                        .font(.system(size: 18))
//                }
//                Text(isGenerating ? "Transforming Your Photo..." : "Transform Photo")
//                    .font(.headline)
//                    .fontWeight(.semibold)
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 16)
//            .background(
//                Group {
//                    if isDisabled {
//                        Color.gray.opacity(0.5)
//                    } else {
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    }
//                }
//            )
//            .foregroundColor(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 7))
//            .shadow(color: isDisabled ? Color.clear : Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
//        }
//        .disabled(isDisabled)
//        .animation(.easeInOut(duration: 0.2), value: isDisabled)
//    }
//}
//
//// MARK: - Animated Title
//struct AnimatedTitle: View {
//    let text: String
//    @State private var shimmer: Bool = false
//    @State private var sparklePulse: Bool = false
//    
//    var body: some View {
//        ZStack {
//            Text(text)
////                .font(.title)
//                .font(.custom("Nunito-Black", size: 30))
//                .foregroundColor(.primary)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color.white.opacity(0.0),
//                            Color.white.opacity(0.9),
//                            Color.white.opacity(0.0)
//                        ]),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                    .rotationEffect(.degrees(20))
//                    .offset(x: shimmer ? 300 : -300)
//                    .mask(
//                        Text(text)
//                            .font(.title)
//                            .fontWeight(.bold)
//                    )
//                )
//                .onAppear {
//                    withAnimation(.linear(duration: 2.2).repeatForever(autoreverses: false)) {
//                        shimmer.toggle()
//                    }
//                }
//            
//            // Subtle sparkles around the title
//            Image(systemName: "sparkles")
//                .foregroundColor(.yellow.opacity(0.9))
//                .offset(x: -70, y: -18)
//                .scaleEffect(sparklePulse ? 1.15 : 0.85)
//                .opacity(sparklePulse ? 1.0 : 0.7)
//                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: sparklePulse)
//            
//            Image(systemName: "star.fill")
//                .foregroundColor(.yellow)
//                .offset(x: 72, y: -6)
//                .scaleEffect(sparklePulse ? 0.9 : 0.6)
//                .opacity(sparklePulse ? 0.95 : 0.6)
//                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.3), value: sparklePulse)
//        }
//        .onAppear { sparklePulse = true }
//    }
//}
//
//// MARK: - Example Images Section
//struct ExampleImagesSection: View {
//    let images: [String]
//    @State private var selectedImageIndex: Int = 0
//    @State private var showFullScreen = false
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            HStack {
//                Image(systemName: "photo.on.rectangle.angled")
//                    .foregroundColor(.blue)
//                Text("Example Gallery")
//                    .font(.custom("Nunito-Bold", size: 22))
////                    .font(.title3)
////                    .fontWeight(.semibold)
//                Spacer()
//            }
//            
//            Text("See what's possible with this style")
//                .font(.caption)
//                .foregroundColor(.secondary)
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
//                ForEach(Array(images.enumerated()), id: \.element) { index, imageName in
//                    Image(imageName)
//                        .resizable()
//                        .aspectRatio(1, contentMode: .fill)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
//                        .onTapGesture {
//                            selectedImageIndex = index
//                            showFullScreen = true
//                        }
//                }
//            }
//        }
//        .sheet(isPresented: $showFullScreen) {
//            FullScreenImageViewer(
//                images: images,
//                selectedIndex: selectedImageIndex,
//                isPresented: $showFullScreen
//            )
//            .presentationDragIndicator(.visible)
//        }
//
//    }
//}
//
//// MARK: - Full Screen Image Viewer
//struct FullScreenImageViewer: View {
//    let images: [String]
//    let selectedIndex: Int
//    @Binding var isPresented: Bool
//    @State private var currentIndex: Int
//    @State private var scale: CGFloat = 1.0
//    @State private var lastScale: CGFloat = 1.0
//    
//    init(images: [String], selectedIndex: Int, isPresented: Binding<Bool>) {
//        self.images = images
//        self.selectedIndex = selectedIndex
//        self._isPresented = isPresented
//        self._currentIndex = State(initialValue: selectedIndex)
//    }
//    
//    var body: some View {
//        ZStack {
//            // Black background
//            Color.black.edgesIgnoringSafeArea(.all)
//            
//            // TabView for swipeable images
//            TabView(selection: $currentIndex) {
//                ForEach(Array(images.enumerated()), id: \.offset) { index, imageName in
//                    GeometryReader { geometry in
//                        Image(imageName)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .scaleEffect(scale)
//                            .gesture(
//                                MagnificationGesture()
//                                    .onChanged { value in
//                                        scale = lastScale * value
//                                    }
//                                    .onEnded { value in
//                                        lastScale = scale
//                                        // Reset if zoomed out too much
//                                        if scale < 1.0 {
//                                            withAnimation(.spring()) {
//                                                scale = 1.0
//                                                lastScale = 1.0
//                                            }
//                                        }
//                                    }
//                            )
//                    }
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .onChange(of: currentIndex) { _ in
//                // Reset zoom when changing images
//                withAnimation {
//                    scale = 1.0
//                    lastScale = 1.0
//                }
//            }
//            
//            // Custom page indicator dots
//            VStack {
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    ForEach(0..<images.count, id: \.self) { index in
//                        Circle()
//                            .fill(currentIndex == index ? Color.white : Color.white.opacity(0.5))
//                            .frame(width: 8, height: 8)
//                            .scaleEffect(currentIndex == index ? 1.2 : 1.0)
//                            .animation(.easeInOut(duration: 0.2), value: currentIndex)
//                    }
//                }
//                .padding(.bottom, 40)
//            }
//            
//            // Close button - positioned at top right
//            VStack {
//                HStack {
//                    Spacer()
//                    Button {
//                        isPresented = false
//                    } label: {
//                        ZStack {
//                            Circle()
//                                .fill(Color.secondary.opacity(1))
//                                .frame(width: 32, height: 32)
//                            
//                            Image(systemName: "xmark")
//                                .font(.system(size: 14, weight: .semibold))
//                                .foregroundColor(.black)
//                        }
//                    }
//                    .padding()
//                }
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - ImagePicker for Camera
//struct ImagePicker: UIViewControllerRepresentable {
//    let sourceType: UIImagePickerController.SourceType
//    @Binding var selectedImage: UIImage?
//    @Environment(\.dismiss) private var dismiss
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = sourceType
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//        init(_ parent: ImagePicker) { self.parent = parent }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//            parent.dismiss()
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.dismiss()
//        }
//    }
//}
//
//// MARK: - Diagonal Overlapping Images
//struct DiagonalOverlappingImages: View {
//    let leftImageName: String
//    let rightImageName: String
//    
//    @State private var arrowWiggle: Bool = false
//
//    var body: some View {
//        GeometryReader { geometry in
//            let imageWidth = geometry.size.width * 0.48
//            let imageHeight = imageWidth * 1.33
//            let arrowYOffset = -imageHeight * 0.15 // About 1/3 from top
//            
//            ZStack(alignment: .center) {
//                // Left image (original) - rotated counter-clockwise
//                Image(leftImageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: imageWidth, height: imageHeight)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .shadow(color: Color.black.opacity(0.25), radius: 12, x: -4, y: 4)
//                    .rotationEffect(.degrees(-8))
//                    .offset(x: -imageWidth * 0.50, y: 0)
//                
//                // Right image (transformed) - rotated clockwise
//                Image(rightImageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: imageWidth, height: imageHeight)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .shadow(color: Color.black.opacity(0.25), radius: 12, x: 4, y: 4)
//                    .rotationEffect(.degrees(8))
//                    .offset(x: imageWidth * 0.50, y: 0)
//                
//                // Arrow image overlapping both images
//                ZStack {
//                    // White circle background for visibility
//                    // ...existing code...
//
//                    // Arrow icon (static)
//                    Image("arrow")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 62, height: 62)
//                        .rotationEffect(.degrees(arrowWiggle ? 4 : -4))
//                        .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: arrowWiggle)
//                }
//                .onAppear { arrowWiggle = true }
//                .offset(x: 0, y: arrowYOffset)
//            }
//            .frame(width: geometry.size.width, height: imageHeight + 20)
//        }
//        .frame(height: 260)
//        .padding(.horizontal, 20)
//    }
//}
//
