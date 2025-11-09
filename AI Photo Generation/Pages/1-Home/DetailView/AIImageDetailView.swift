//
//  AIImageDetailView.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/8/25.
//

import SwiftUI
import PhotosUI

struct AIImageDetailView: View {
    let item: InfoPacket
    
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
    @Environment(\.dismiss) private var dismiss
    
    private let imageAspects: [String] = ["1:1", "3:4", "4:3", "9:16", "16:9"]
    private let imageAspectOptions: [AspectRatioOption] = [
        AspectRatioOption(id: "1:1", label: "1:1", width: 1, height: 1, platforms: ["Instagram"]),
        AspectRatioOption(id: "3:4", label: "3:4", width: 3, height: 4, platforms: ["Portrait"]),
        AspectRatioOption(id: "4:3", label: "4:3", width: 4, height: 3, platforms: ["Photo Prints"]),
        AspectRatioOption(id: "9:16", label: "9:16", width: 9, height: 16, platforms: ["TikTok", "Reels"]),
        AspectRatioOption(id: "16:9", label: "16:9", width: 16, height: 9, platforms: ["YouTube"])
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
                            .frame(width: geometry.size.width, height: 320)
                            .clipped()
                        
                        // Gradient overlay for better text readability
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 280)
                        
                        // Model name overlay on banner
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.modelName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("AI Image Model")
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
                                
                                Text("per image")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                        .padding()
                    }
                    .offset(y: -geometry.safeAreaInsets.top)
                    .padding(.bottom, -geometry.safeAreaInsets.top)
                
                VStack(spacing: 24) {
                    // AI Model Description Section
                    VStack(spacing: 12) {
                        Divider()
                        
                        HStack(spacing: 6) {
                            Image(systemName: "cpu")
                                .foregroundColor(.secondary)
                            Text("Model Description")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        
                        // Model Details Card (without image now)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.modelDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                        
                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                
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
                
                // Prompt
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
                                Text("Describe the image you want to generate...")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray.opacity(0.5))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 16)
                                    .allowsHitTesting(false)
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
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
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
        // Simulate image generation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isGenerating = false
            // This is where you'd actually call the API
        }
    }
}

