//
//  PhotoFiltersView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/19/25.
//

import SwiftUI
import PhotosUI

struct PhotoFiltersView: View {
    
    @State private var prompt: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showPhotoPicker: Bool = false
    @State private var selectedFilter: String? = "Filter 1"
    
    // Sample placeholder data for 36 filters
    let filters = Array(1...36).map { "Filter \($0)" }
    
    // 4 columns grid layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Scrollable Filters Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filters, id: \.self) { filter in
                        FilterThumbnail(
                            title: filter,
                            isSelected: selectedFilter == filter
                        )
                        .onTapGesture {
                            selectedFilter = filter
                        }
                    }
                }
                .padding(16)
            }
            
            // MARK: - Fixed Bottom Section
            VStack(spacing: 16) {
                Divider()
                
                // Photo Upload Button
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
        .navigationTitle("Photo Filters")
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Supporting Views

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

struct FilterThumbnail: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            // Filter preview
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.15))
                .frame(height: 80)
                .overlay(
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(20)
                )
                .overlay(
                    // Check icon in top right corner
                    VStack {
                        HStack {
                            Spacer()
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
                        }
                        Spacer()
                    }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
            
            // Filter name
            Text(title)
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
    }
}

