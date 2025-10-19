//
//  ModelDetailView.swift
//  AI Photo Generation
//
//  Created by Assistant on 10/11/25.
//

import SwiftUI
import PhotosUI

struct ModelDetailView: View {
    let initialModel: Model
    let modelType: ModelType

    @State private var prompt: String = ""
    @State private var isGenerating: Bool = false
    @State private var selectedImage: UIImage?
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showCamera: Bool = false
    @State private var showPhotoPicker: Bool = false

    @State private var selectedModelId: String

    init(model: Model, modelType: ModelType) {
        self.initialModel = model
        self.modelType = modelType
        _selectedModelId = State(initialValue: model.modelId)
    }

    private var availableModels: [Model] {
        switch modelType {
        case .video:
            return videoModels
        case .image:
            return imageModels
        }
    }

    private var selectedModel: Model {
        availableModels.first(where: { $0.modelId == selectedModelId }) ?? initialModel
    }

    private var generateLabel: String {
        switch modelType {
        case .video: return isGenerating ? "Generating..." : "Generate Video"
        case .image: return isGenerating ? "Generating..." : "Generate Image"
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    HStack {
                        Text(modelType == .video ? "Transform to Video" : "Create Image")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)

                    HStack(spacing: 8) {
                        Image(selectedModel.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.42, height: 250)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        if selectedImage != nil {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.blue.opacity(0.9))
                        } else {
                            Image(systemName: "arrow.right.circle")
                                .font(.system(size: 28))
                                .foregroundColor(.gray.opacity(0.6))
                        }

                        AddPhotoButton(
                            selectedImage: $selectedImage,
                            selectedPhotoItem: $selectedPhotoItem,
                            showCamera: $showCamera,
                            showPhotoPicker: $showPhotoPicker
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.42, height: 250)
                    }
                    .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 16) {
                    // Model picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Model")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Picker("Model", selection: $selectedModelId) {
                            ForEach(availableModels, id: \.modelId) { model in
                                Text(model.name).tag(model.modelId)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.blue)
                    }

                    PromptSection(prompt: $prompt)

                    // Generate button (customized label)
                    Button(action: {
                        isGenerating = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isGenerating = false
                        }
                    }) {
                        HStack {
                            if isGenerating {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: modelType == .video ? "film" : "wand.and.stars")
                            }
                            Text(generateLabel)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isGenerating || prompt.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(isGenerating || prompt.isEmpty)
                    .opacity(prompt.isEmpty ? 0.6 : 1.0)

                    AIModelSection(
                        modelName: selectedModel.name,
                        modelDescription: selectedModel.description,
                        modelImageName: selectedModel.imageName
                    )

                    Divider()

                    ExamplesSection(images: [])
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(selectedModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
        }
        .onChange(of: selectedPhotoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
        .onAppear {
            prompt = ""
        }
    }
}


// MARK: - Examples Section
struct ExamplesSection: View {
    let images: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Examples")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 8)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                if images.isEmpty {
                    ForEach(0..<6, id: \.self) { _ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.06))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )

                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 28))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                } else {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
            }
        }
        .padding(.top, 4)
    }
}


// MARK: - Add Photo Button
struct AddPhotoButton: View {
    @Binding var selectedImage: UIImage?
    @Binding var selectedPhotoItem: PhotosPickerItem?
    @Binding var showCamera: Bool
    @Binding var showPhotoPicker: Bool

    @State private var wiggle: Bool = false

    var body: some View {
        if let selectedImage = selectedImage {
            // Show selected image with remove button
            ZStack(alignment: .topTrailing) {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 2)
                    )

                Button(action: { self.selectedImage = nil }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                        .background(Circle().fill(Color.red))
                }
                .padding(6)
            }
        } else {
            // Show "Add A Photo" button - directly opens photo picker
            Button(action: { showPhotoPicker = true }) {
                VStack(spacing: 16) {
                    // Icon with plus badge
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 50))
                            .foregroundColor(.gray.opacity(0.4))
                    }

                    VStack(spacing: 4) {
                        Text("Add A Photo")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)

                        Text("Tap to upload or take")
                            .font(.caption2)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(Color.gray.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(style: StrokeStyle(lineWidth: 3.5, dash: [6, 4]))
                        .foregroundColor(.gray.opacity(0.4))
                )
            }
            .rotationEffect(.degrees(wiggle ? 2.2 : -2.2))
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: wiggle)
            .onAppear { wiggle = true }
            .photosPicker(
                isPresented: $showPhotoPicker,
                selection: $selectedPhotoItem,
                matching: .images
            )
            .onChange(of: selectedPhotoItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = uiImage
                    }
                }
            }
        }
    }
}


// MARK: - Prompt Section
struct PromptSection: View {
    @Binding var prompt: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Prompt")
                .font(.headline)
                .foregroundColor(.secondary)

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
    }
}


// MARK: - AI Model Section
struct AIModelSection: View {
    let modelName: String
    let modelDescription: String
    let modelImageName: String
    let price: Double?
    let priceCaption: String?

    init(
        modelName: String,
        modelDescription: String,
        modelImageName: String,
        price: Double? = nil,
        priceCaption: String? = nil
    ) {
        self.modelName = modelName
        self.modelDescription = modelDescription
        self.modelImageName = modelImageName
        self.price = price
        self.priceCaption = priceCaption
    }

    var body: some View {
        VStack(spacing: 12) {

//            HStack{
//                Spacer()
//                // Optional price caption (e.g., "Price per 8s video" or "Price per image")
//                if let priceCaption = priceCaption {
//                    HStack {
//                        Spacer()
//                        Text(priceCaption)
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                }
//            }

            HStack(alignment: .top) {
                // Model Image on the left
                Image(modelImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // Model name and description on the right
                VStack(alignment: .leading, spacing: 6) {

                    HStack(alignment: .top) {
                        Text(modelName)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)

                        Spacer()

                        // Optional price badge on the trailing side
                        if let price = price {
                            Text(String(format: "$%.2f", price))
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black)
                                .cornerRadius(6)
                        }
                    }

                    Text(modelDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }

                Spacer()
            }
            .padding(12)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}
