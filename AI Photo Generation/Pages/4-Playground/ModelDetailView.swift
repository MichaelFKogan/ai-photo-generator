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


