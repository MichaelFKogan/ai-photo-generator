import SwiftUI

struct AIModelsView: View {
    // MARK: - State
    @State private var sortOrder = 0 // 0 = Default, 1 = Low->High, 2 = High->Low
    @State private var videoFilterIndex: Int = 0 // 0 = All, 1 = Text to Video, 2 = Image to Video, 3 = Audio
    @State private var imageFilterIndex: Int = 0 // 0 = All, 1 = Text to Image, 2 = Image to Image
    
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
    
    private var filteredAndSortedImageModels: [InfoPacket] {
        var models = imageModelsRow
        
        // Apply category filter
        switch imageFilterIndex {
        case 1: models = models.filter { imageCapabilities(for: $0).contains("Text to Image") }
        case 2: models = models.filter { imageCapabilities(for: $0).contains("Image to Image") }
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
    
    private func imageCapabilities(for model: InfoPacket) -> [String] {
        return model.capabilities
    }
    
    // Check if any filters are active
    private var hasActiveFilters: Bool {
        return videoFilterIndex != 0 || imageFilterIndex != 0 || sortOrder != 0
    }
    
    // Clear all filters
    private func clearAllFilters() {
        withAnimation {
            videoFilterIndex = 0
            imageFilterIndex = 0
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
                            Text("Video:")
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
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        
                        // Image Filters
                        HStack(spacing: 8) {
                            Text("Image:")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 6) {
                                    CompactFilterPill(title: "All", isSelected: imageFilterIndex == 0, color: .blue) {
                                        withAnimation { imageFilterIndex = 0 }
                                    }
                                    CompactFilterPill(title: "Text to Image", isSelected: imageFilterIndex == 1, color: .blue) {
                                        withAnimation { imageFilterIndex = 1 }
                                    }
                                    CompactFilterPill(title: "Image to Image", isSelected: imageFilterIndex == 2, color: .blue) {
                                        withAnimation { imageFilterIndex = 2 }
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Main Grid (Enhanced)
                    HStack(alignment: .top, spacing: 16) {
                        // LEFT COLUMN — Video Models
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(
                                icon: "video.fill",
                                title: "Video",
                                color: .purple,
                                count: filteredAndSortedVideoModels.count
                            )
                            
                            if filteredAndSortedVideoModels.isEmpty {
                                EmptyStateView(
                                    icon: "video.slash",
                                    message: "No video models found"
                                )
                            } else {
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
                        }
                        .frame(maxWidth: .infinity)
                        
                        // RIGHT COLUMN — Image Models
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(
                                icon: "photo.on.rectangle",
                                title: "Images",
                                color: .blue,
                                count: filteredAndSortedImageModels.count
                            )
                            
                            if filteredAndSortedImageModels.isEmpty {
                                EmptyStateView(
                                    icon: "photo.slash",
                                    message: "No image models found"
                                )
                            } else {
                                ForEach(filteredAndSortedImageModels) { item in
                                    NavigationLink(destination: AIImageDetailView(item: item)) {
                                        EnhancedModelCard(
                                            item: item,
                                            capabilities: imageCapabilities(for: item),
                                            mediaType: .image
                                        )
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Playground")
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
                                Image(systemName: "line.3.horizontal.decrease")
                                    .accessibilityLabel("Sort")
                            }
                        }
                        
                        // // Credits Display
                        // HStack(spacing: 6) {
                        //     Image(systemName: "diamond.fill")
                        //         .foregroundStyle(
                        //             LinearGradient(
                        //                 colors: [.blue, .purple],
                        //                 startPoint: .topLeading,
                        //                 endPoint: .bottomTrailing
                        //             )
                        //         )
                        //         .font(.system(size: 8))
                            
                        //     Text("$5.00")
                        //         .font(.system(size: 14, weight: .semibold, design: .rounded))
                        //         .foregroundColor(.primary)
                        //     Text("credits left")
                        //         .font(.caption2)
                        //         .foregroundColor(.secondary)
                        // }
                        // .padding(.horizontal, 12)
                        // .padding(.vertical, 6)
                        // .background(
                        //     RoundedRectangle(cornerRadius: 20)
                        //         .fill(Color.secondary.opacity(0.1))
                        // )
                        // .overlay(
                        //     RoundedRectangle(cornerRadius: 20)
                        //         .strokeBorder(
                        //             LinearGradient(
                        //                 colors: [.blue, .purple],
                        //                 startPoint: .leading,
                        //                 endPoint: .trailing
                        //             )
                        //         )
                        // )
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct EnhancedModelCard: View {
    let item: InfoPacket
    let capabilities: [String]
    let mediaType: MediaType
    
    enum MediaType {
        case video, image
        
        var color: Color {
            switch self {
            case .video: return .purple
            case .image: return .blue
            }
        }
        
        var icon: String {
            switch self {
            case .video: return "video.fill"
            case .image: return "photo.fill"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Image with overlays
            ZStack(alignment: .bottom) {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Gradient overlay for better text readability
                LinearGradient(
                    colors: [Color.black.opacity(0.6), Color.clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
                .frame(height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Capability pills at bottom
                HStack(spacing: 4) {
                    ForEach(capabilities.prefix(2), id: \.self) { cap in
                        Text(cap)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(mediaType.color.opacity(0.9))
                            .clipShape(Capsule())
                    }
                    if capabilities.count > 2 {
                        Text("+\(capabilities.count - 2)")
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.secondary.opacity(0.9))
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(8)
            }
            .overlay(alignment: .topLeading) {
                HStack(spacing: 4) {
                    Image(systemName: mediaType.icon)
                        .font(.caption)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().fill(mediaType.color.opacity(0.8)))
                .padding(6)
            }
            .overlay(alignment: .topTrailing) {
                Text("$\(item.cost, specifier: "%.2f")")
                    .font(.custom("Nunito-Bold", size: 11))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                    .padding(6)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            
            // Title
            Text(item.title)
                .font(.custom("Nunito-ExtraBold", size: 13))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
}

struct SectionHeader: View {
    let icon: String
    let title: String
    let color: Color
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Text("\(count)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.secondary.opacity(0.1))
                .clipShape(Capsule())
        }
        .foregroundColor(color)
    }
}

struct FilterPillButton: View {
    let title: String
    var count: Int? = nil
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
                if let count = count {
                    Text("(\(count))")
                        .font(.caption2)
                }
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isSelected ?
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing) :
                LinearGradient(colors: [Color.secondary.opacity(0.1)], startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.clear : Color.secondary.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct StatCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct EmptyStateView: View {
    let icon: String
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.secondary.opacity(0.5))
            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

struct CompactFilterPill: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .font(.system(size: 11))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .foregroundColor(isSelected ? .white : color)
                .background(isSelected ? color : color.opacity(0.12))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : color.opacity(0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}