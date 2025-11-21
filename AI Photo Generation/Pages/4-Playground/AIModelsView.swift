import SwiftUI

struct AIModelsView: View {
    // MARK: - State
    @State private var sortOrder = 0 // 0 = Default, 1 = Low->High, 2 = High->Low
    @State private var videoFilterIndex: Int = 0 // 0 = All, 1 = Text to Video, 2 = Image to Video, 3 = Audio
    @State private var imageFilterIndex: Int = 0 // 0 = All, 1 = Text to Image, 2 = Image to Image
    @State private var searchText: String = ""
    
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
        
        // Apply search filter
        if !searchText.isEmpty {
            models = models.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.modelName.localizedCaseInsensitiveContains(searchText) }
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
        
        // Apply search filter
        if !searchText.isEmpty {
            models = models.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.modelName.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply sort
        switch sortOrder {
        case 1: return models.sorted { $0.cost < $1.cost }
        case 2: return models.sorted { $0.cost > $1.cost }
        default: return models
        }
    }
    
    // Capability detection functions (similar to ModelPickerView)
    private func videoCapabilities(for model: InfoPacket) -> [String] {
        // You'll need to add capability metadata to your InfoPacket model
        // For now, using a similar hash-based approach
        let sum = model.modelName.unicodeScalars.map { Int($0.value) }.reduce(0, +)
        var caps: [String] = []
        if sum % 2 == 0 { caps.append("Text to Video") }
        if sum % 3 == 0 { caps.append("Image to Video") }
        if sum % 5 == 0 { caps.append("Audio") }
        if caps.isEmpty { caps = ["Text to Video"] }
        return caps
    }
    
    private func imageCapabilities(for model: InfoPacket) -> [String] {
        let sum = model.modelName.unicodeScalars.map { Int($0.value) }.reduce(0, +)
        var caps: [String] = []
        if sum % 2 == 0 { caps.append("Text to Image") }
        if sum % 3 == 0 { caps.append("Image to Image") }
        if caps.isEmpty { caps = ["Text to Image"] }
        return caps
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search models...", text: $searchText)
                            .textFieldStyle(.plain)
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // MARK: - Filter Pills Section
                    VStack(spacing: 12) {
                        // Video Filters
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Video Filters")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    FilterPillButton(title: "All", count: videoModelsRow.count, isSelected: videoFilterIndex == 0) {
                                        withAnimation { videoFilterIndex = 0 }
                                    }
                                    FilterPillButton(title: "Text to Video", isSelected: videoFilterIndex == 1) {
                                        withAnimation { videoFilterIndex = 1 }
                                    }
                                    FilterPillButton(title: "Image to Video", isSelected: videoFilterIndex == 2) {
                                        withAnimation { videoFilterIndex = 2 }
                                    }
                                    FilterPillButton(title: "Audio", isSelected: videoFilterIndex == 3) {
                                        withAnimation { videoFilterIndex = 3 }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Image Filters
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Image Filters")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    FilterPillButton(title: "All", count: imageModelsRow.count, isSelected: imageFilterIndex == 0) {
                                        withAnimation { imageFilterIndex = 0 }
                                    }
                                    FilterPillButton(title: "Text to Image", isSelected: imageFilterIndex == 1) {
                                        withAnimation { imageFilterIndex = 1 }
                                    }
                                    FilterPillButton(title: "Image to Image", isSelected: imageFilterIndex == 2) {
                                        withAnimation { imageFilterIndex = 2 }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // MARK: - Stats Row
                    HStack(spacing: 16) {
                        StatCard(
                            icon: "video.fill",
                            title: "\(filteredAndSortedVideoModels.count)",
                            subtitle: "Video Models",
                            color: .purple
                        )
                        
                        StatCard(
                            icon: "photo.fill",
                            title: "\(filteredAndSortedImageModels.count)",
                            subtitle: "Image Models",
                            color: .blue
                        )
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
                        // Sort Menu
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
                            Image(systemName: "arrow.up.arrow.down.circle")
                                .foregroundColor(.primary)
                        }
                        
                        // Credits Display
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