//
//  PhotoFiltersView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/19/25.
//

import SwiftUI
import PhotosUI

// MARK: - Filter Model
struct FilterItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String   // Local asset or URL later
}

// MARK: - Main View
struct PhotoFiltersView: View {
    
    @State private var prompt: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showPhotoPicker: Bool = false
    @State private var selectedFilter: String? = "Anime"
    
    // MARK: - Sample Filters
    let filters: [FilterItem] = [
        FilterItem(name: "Anime", imageName: "anime1"),
        FilterItem(name: "Minecraft", imageName: "minecraft1"),
        FilterItem(name: "Cyberpunk", imageName: "cyberpunk1"),
        
        FilterItem(name: "Mini World", imageName: "micro-landscape-mini-world1"),
        FilterItem(name: "Plastic Bubble Figure", imageName: "plasticbubblefigure1"),
        FilterItem(name: "Designer Toy Figure", imageName: "trending1"),
        
        FilterItem(name: "Felt 3D Polaroid", imageName: "felt3dpolaroid1"),
        FilterItem(name: "Snow Globe", imageName: "glassball1"),
        FilterItem(name: "Futuristic", imageName: "futuristic1"),
        
        FilterItem(name: "Low Key Lighting", imageName: "lowkeylighting1"),
        
        FilterItem(name: "Nature Glow", imageName: "filter11"),
        FilterItem(name: "Noir", imageName: "filter12"),
        FilterItem(name: "Golden Hour", imageName: "filter13"),
        FilterItem(name: "Pastel", imageName: "filter14"),
        FilterItem(name: "Futuristic", imageName: "filter15"),
        FilterItem(name: "Classic", imageName: "filter16")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Scrollable Filters Grid
                ScrollView {
                    GeometryReader { proxy in
                        let spacing: CGFloat = 8
                        let totalSpacing = spacing * 3 // 4 columns -> 3 gaps
                        let availableWidth = proxy.size.width - totalSpacing - 32 // padding
                        let itemSize = availableWidth / 4
                        
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: 4),
                            spacing: spacing
                        ) {
                            ForEach(filters) { filter in
                                FilterThumbnail(
                                    title: filter.name,
                                    imageName: filter.imageName,
                                    isSelected: selectedFilter == filter.name,
                                    size: itemSize
                                )
                                .onTapGesture {
                                    selectedFilter = filter.name
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                    .frame(minHeight: 600) // ensures scroll region height
                }
                
                // MARK: - Fixed Bottom Section
                VStack(spacing: 16) {
                    Divider()
                    
                    // Upload Button
                    SpinningPlusButton(showPhotoPicker: $showPhotoPicker)
                        .photosPicker(
                            isPresented: $showPhotoPicker,
                            selection: $selectedPhotoItem,
                            matching: .images
                        )
                        .padding(.horizontal, 16)
                    
                    // Cost Badge
                    HStack {
                        Spacer()
                        CostBadge(cost: 0.04)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 80)
                }
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -2)
            }
            
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Photo Filters")
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
                    creditsDisplay
                }
            }
        }
    }
    
    // MARK: - Credits Display
    private var creditsDisplay: some View {
        HStack(spacing: 6) {
            Image(systemName: "diamond.fill")
                .foregroundStyle(
                    LinearGradient(colors: [.blue, .purple],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
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
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color.secondary.opacity(0.1)))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    LinearGradient(colors: [.blue, .purple],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
        )
    }
}

// MARK: - Cost Badge
struct CostBadge: View {
    let cost: Double
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "tag.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text("Cost: $\(cost, specifier: "%.2f")")
                .font(.custom("Nunito-Bold", size: 16))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(8)
    }
}

// MARK: - Filter Thumbnail (Square)
struct FilterThumbnail: View {
    let title: String
    let imageName: String
    let isSelected: Bool
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 3)
                    )
                    .overlay(
                        Group {
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                                    .background(
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [.blue, .purple],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 24, height: 24)
                                    )
                                    .padding(6)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        },
                        alignment: .topTrailing
                    )
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
            
            Text(title)
                .font(.caption2)
                .lineLimit(1)
                .foregroundColor(.secondary)
                .frame(width: size)
        }
    }
}
