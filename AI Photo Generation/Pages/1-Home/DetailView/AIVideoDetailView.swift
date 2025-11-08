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
    @Environment(\.dismiss) private var dismiss
    
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
                // AI Model Section - Display the selected model info
                VStack(spacing: 12) {
                    Divider()
                    
//                    HStack {
//                        Image(systemName: "video.fill")
//                            .font(.title2)
//                        Text("Create Video")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
//                    .foregroundColor(.blue)
//                    .padding(.bottom, 6)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "cpu")
                            .foregroundColor(.secondary)
                        Text("AI Model")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    // Model Details Card
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.modelImageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(item.modelName)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text(item.modelDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            
                            HStack {
                                Text(String(format: "$%.2f", item.cost))
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black)
                                    .cornerRadius(6)
                                
                                Text("per 8s video")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(12)
                    
                    Divider()
                }
                .padding(.horizontal)
                
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
            .padding(.top)
            .padding(.bottom, 200)
        }
//        .navigationTitle(item.modelName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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
                Text(modelName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(modelDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text(String(format: "$%.2f", price))
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black)
                        .cornerRadius(6)
                    
                    Text(priceCaption)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
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
