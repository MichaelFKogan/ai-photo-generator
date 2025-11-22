import PhotosUI
import SwiftUI

struct VideoModels: View {
    // MARK: - State

    @State private var sortOrder = 0 // 0 = Default, 1 = Low->High, 2 = High->Low
    @State private var videoFilterIndex: Int = 0 // 0 = All, 1 = Text to Video, 2 = Image to Video, 3 = Audio

    // MARK: - Computed Properties

    private var filteredAndSortedVideoModels: [InfoPacket] {
        var models = videoModelsRow

        // Apply category filter
        switch videoFilterIndex {
        case 1: models = models.filter { videoCapabilities(for: $0).contains("Text to Video") }
        case 2: models = models.filter { videoCapabilities(for: $0).contains("Image to Video") }
        case 3: models = models.filter { videoCapabilities(for: $0).contains("Audio") }
        default: break
        }

        // Apply sort
        switch sortOrder {
        case 1: return models.sorted { $0.cost < $1.cost }
        case 2: return models.sorted { $0.cost > $1.cost }
        default: return models
        }
    }

    // Capability detection functions - now using real data
    private func videoCapabilities(for model: InfoPacket) -> [String] {
        return model.capabilities
    }

    // Check if any filters are active
    private var hasActiveFilters: Bool {
        return videoFilterIndex != 0 || sortOrder != 0
    }

    // Clear all filters
    private func clearAllFilters() {
        withAnimation {
            videoFilterIndex = 0
            sortOrder = 0
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    // MARK: - Filter Pills Section

                    VStack(spacing: 10) {
                        // Video Filters
                        HStack(spacing: 8) {
                            Text("Filter:")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 6) {
                                    CompactFilterPill(title: "All", isSelected: videoFilterIndex == 0, color: .purple) {
                                        withAnimation { videoFilterIndex = 0 }
                                    }
                                    CompactFilterPill(title: "Text to Video", isSelected: videoFilterIndex == 1, color: .purple) {
                                        withAnimation { videoFilterIndex = 1 }
                                    }
                                    CompactFilterPill(title: "Image to Video", isSelected: videoFilterIndex == 2, color: .purple) {
                                        withAnimation { videoFilterIndex = 2 }
                                    }
                                    CompactFilterPill(title: "Audio", isSelected: videoFilterIndex == 3, color: .purple) {
                                        withAnimation { videoFilterIndex = 3 }
                                    }
                                }
                                .padding(.vertical, 2)
                            }

                            // Clear Filters Button
                            if hasActiveFilters {
                                Button(action: clearAllFilters) {
                                    Text("Clear")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.purple)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // MARK: - Video Models Section

                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(
                            icon: "video.fill",
                            title: "Video Models",
                            color: .purple,
                            count: filteredAndSortedVideoModels.count
                        )
                        .padding(.horizontal)

                        if filteredAndSortedVideoModels.isEmpty {
                            EmptyStateView(
                                icon: "video.slash",
                                message: "No video models found"
                            )
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(filteredAndSortedVideoModels) { item in
                                    NavigationLink(destination: AIVideoDetailView(item: item)) {
                                        EnhancedModelCard(
                                            item: item,
                                            capabilities: videoCapabilities(for: item),
                                            mediaType: .video
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }

            // MARK: - Navigation Bar

            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Video Models")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        // Sort Menu (styled like ModelPickerView)
                        Menu {
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
                            HStack {
                                Text("Sort by price")
                                    .font(.caption)
                                    .foregroundColor(.purple)
                                Image(systemName: "line.3.horizontal.decrease")
                                    .foregroundColor(.purple)
                                    .accessibilityLabel("Sort")
                            }
                        }
                    }
                }
            }
        }
    }
}

// Note: Supporting views (EnhancedModelCard, SectionHeader, CompactFilterPill, EmptyStateView, etc.)
// are already defined in 1-ImageModels.swift and are shared across both views.
