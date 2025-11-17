//
//  AIVideoDetailView.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/8/25.
//

import SwiftUI
import PhotosUI

struct AIVideoDetailView: View {
    let item: InfoPacket
    
    @State private var prompt: String = ""
    @State private var isGenerating: Bool = false
    @State private var referenceImages: [UIImage] = []
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var videoDurationIndex: Int = 1 // default to 8s
    @State private var videoAspectIndex: Int = 0 // default to 9:16
    @FocusState private var isPromptFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    private let videoDurations: [String] = ["5s", "8s", "12s"]
    private let videoAspects: [String] = ["9:16", "16:9", "1:1"]
    private let videoAspectOptions: [AspectRatioOption] = [
        AspectRatioOption(id: "9:16", label: "9:16", width: 9, height: 16, platforms: ["TikTok", "Shorts", "Reels"]),
        AspectRatioOption(id: "16:9", label: "16:9", width: 16, height: 9, platforms: ["YouTube"]),
        AspectRatioOption(id: "1:1", label: "1:1", width: 1, height: 1, platforms: ["Instagram"])
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // Banner Image at top - extends behind navigation bar
                    ZStack(alignment: .bottom) {
                        Image(item.modelImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 320)
                            .clipped()
                        
                        // Only gradient behind the text section
                        VStack {
                            Spacer()
                            
                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.modelName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                        Text("AI Video Model")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text(String(format: "$%.2f", item.cost))
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(6)
                                        
                                        Text("per 8s video")
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
                                    colors: [Color.black.opacity(0.8), Color.black.opacity(0.1)],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                        }
                    }
                    .frame(height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    VStack(spacing: 24) {
                        
//                        Divider()
//                            .padding(.horizontal)
//                            .padding(.top, 8)
                        
                        // Example Images Section
                        if !item.exampleImages.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "photo.stack")
                                        .foregroundColor(.secondary)
                                    Text("Example Results")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(item.exampleImages, id: \.self) { imageName in
                                            Image(imageName)
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
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
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
                                .overlay(alignment: .topLeading) {
                                    if prompt.isEmpty {
                                        Text("Describe the video you want to generate...")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray.opacity(0.5))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 16)
                                            .allowsHitTesting(false)
                                    }
                                }
                                .focused($isPromptFocused)
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
                        
                        // Generate Video button
                        Button(action: generate) {
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
                    .padding(.bottom, 200)
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isPromptFocused = false
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
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
        isGenerating = true
        // Simulate video generation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isGenerating = false
            // This is where you'd actually call the API
        }
    }
}

// MARK: - AI Model Section Component
struct AIModelSectionTwo: View {
    let modelName: String
    let modelDescription: String
    let modelImageName: String
    let price: Double
    let priceCaption: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(modelImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(modelName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(String(format: "$%.2f", price))
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black)
                            .cornerRadius(6)
                        
                        Text(priceCaption)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                
                Text(modelDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

// MARK: - Tab Header Button Component
struct TabHeaderButtonTwo<Label: View>: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    @ViewBuilder let label: () -> Label
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                label()
                    .font(.subheadline)
                    .foregroundColor(isSelected ? .blue : .secondary)
                Rectangle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

