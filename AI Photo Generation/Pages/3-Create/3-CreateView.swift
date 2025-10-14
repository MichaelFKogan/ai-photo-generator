//
//  CreateView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
//                    Text("Create with AI")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.top)
                    
                    // Create options
                    VStack(spacing: 20) {
                        // Generate from prompt
                        NavigationLink(destination: Text("Generate Image from Prompt - Coming Soon")) {
                            HStack {
                                Image(systemName: "text.cursor")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                VStack(alignment: .leading) {
                                    Text("Text To Image")
                                        .font(.headline)
                                    Text("Create images from text descriptions")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Transform existing image
                        NavigationLink(destination: Text("Transform Image - Coming Soon")) {
                            HStack {
                                Image(systemName: "photo.artframe")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                VStack(alignment: .leading) {
                                    Text("Image To Image")
                                        .font(.headline)
                                    Text("Transform your existing photos with AI")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Generate video
                        NavigationLink(destination: Text("Generate Video - Coming Soon")) {
                            HStack {
                                Image(systemName: "video")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                VStack(alignment: .leading) {
                                    Text("Generate Video")
                                        .font(.headline)
                                    Text("Create videos from text or images")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())

                    NavigationLink(destination: ModelsView()) {
                        HStack {
                            Image(systemName: "cpu")
                                .font(.title2)
                                .foregroundColor(.indigo)
                            VStack(alignment: .leading) {
                                Text("Browse AI Models")
                                    .font(.headline)
                                Text("Compare capabilities, price, tips")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.indigo.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
                    
                    // Trending
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Trending")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["Cyberpunk City", "Fantasy Portrait", "Nature Macro", "Abstract Art", "Futuristic"], id: \.self) { item in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.orange.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "flame")
                                                    .font(.title2)
                                                    .foregroundColor(.orange)
                                            )
                                        Text(item)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Popular Styles
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Styles")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["Realistic", "Anime", "Oil Painting", "Sketch", "Digital Art"], id: \.self) { style in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "paintbrush")
                                                    .font(.title2)
                                                    .foregroundColor(.gray)
                                            )
                                        Text(style)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Popular Image Generations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Image Generations")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["Portrait", "Landscape", "Character", "Product", "Architecture"], id: \.self) { item in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.blue.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "photo")
                                                    .font(.title2)
                                                    .foregroundColor(.blue)
                                            )
                                        Text(item)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Popular Video Generations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Video Generations")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["Text to Video", "Loop Animation", "Motion Graphics", "Timelapse", "Cinematic"], id: \.self) { item in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.purple.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "video.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.purple)
                                            )
                                        Text(item)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Popular Image Transformations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Image Transformations")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["Style Transfer", "Upscale", "Colorize", "Background Removal", "Face Enhance"], id: \.self) { item in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.green.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                            .overlay(
                                                Image(systemName: "wand.and.stars")
                                                    .font(.title2)
                                                    .foregroundColor(.green)
                                            )
                                        Text(item)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 250)
            }
            .navigationTitle("Create")
        }
    }
}

#Preview {
    CreateView()
}
