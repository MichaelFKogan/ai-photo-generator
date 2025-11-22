import PhotosUI
import SwiftUI

struct ImageModels: View {
    // MARK: - State

    @State private var sortOrder = 0 // 0 = Default, 1 = Low->High, 2 = High->Low
    @State private var imageFilterIndex: Int = 0 // 0 = All, 1 = Text to Image, 2 = Image to Image

    // MARK: - Computed Properties

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
    private func imageCapabilities(for model: InfoPacket) -> [String] {
        return model.capabilities
    }

    // Check if any filters are active
    private var hasActiveFilters: Bool {
        return imageFilterIndex != 0 || sortOrder != 0
    }

    // Clear all filters
    private func clearAllFilters() {
        withAnimation {
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
                        // Image Filters
                        HStack(spacing: 8) {
                            Text("Filter:")
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
                    }
                    .padding(.horizontal)

                    // MARK: - Image Models Section

                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(
                            icon: "photo.on.rectangle",
                            title: "Image Models",
                            color: .blue,
                            count: filteredAndSortedImageModels.count
                        )
                        .padding(.horizontal)

                        if filteredAndSortedImageModels.isEmpty {
                            EmptyStateView(
                                icon: "photo.slash",
                                message: "No image models found"
                            )
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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
                    Text("Image Models")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .cyan],
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
                .foregroundColor(.white).opacity(0.8)
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

// MARK: - Section Header

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
                .background(Color.secondary.opacity(0.2))
                .clipShape(Capsule())
        }
        .foregroundColor(color)
    }
}

// MARK: - Filter Pill Button

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

// MARK: - Stat Card

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

// MARK: - Empty State View

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

// MARK: - Compact Filter Pill

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

// MARK: - Reference Images Section (Multi-select)

struct ReferenceImagesSection: View {
    @Binding var referenceImages: [UIImage]
    @Binding var selectedPhotoItems: [PhotosPickerItem]
    let color: Color // Add color parameter

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "photo.on.rectangle")
                    .foregroundColor(color) // Use the color parameter
                Text("Image(s) (Optional)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            Text("Upload an image to transform it, or use as reference with your prompt")
                .font(.caption)
                .foregroundColor(.secondary.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 4)

            LazyVGrid(columns: columns, spacing: 12) {
                // Existing selected reference images
                ForEach(referenceImages.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: referenceImages[index])
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(color.opacity(0.6), lineWidth: 1) // Use the color parameter
                            )

                        Button(action: { referenceImages.remove(at: index) }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.red))
                        }
                        .padding(6)
                    }
                }

                // Add images tile
                PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: 10, matching: .images) {
                    VStack(spacing: 12) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 28))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        VStack(spacing: 4) {
                            Text("Add Images")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                            Text("Up to 10")
                                .font(.caption2)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.03))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(style: StrokeStyle(lineWidth: 3.5, dash: [6, 4]))
                            .foregroundColor(.gray.opacity(0.4))
                    )
                }
                .onChange(of: selectedPhotoItems) { newItems in
                    Task {
                        var newlyAdded: [UIImage] = []
                        for item in newItems {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data)
                            {
                                newlyAdded.append(image)
                            }
                        }
                        referenceImages.append(contentsOf: newlyAdded)
                        selectedPhotoItems.removeAll()
                    }
                }
            }
        }
    }
}

// MARK: - Visual Selectors (Aspect Ratio & Size)

struct AspectRatioOption: Identifiable {
    let id: String
    let label: String
    let width: CGFloat
    let height: CGFloat
    let platforms: [String]
}

struct SizeOption: Identifiable {
    let id: String
    let label: String
    let widthPx: Int
    let heightPx: Int
}

// MARK: - Aspect Ratio Selector

struct AspectRatioSelector: View {
    let options: [AspectRatioOption]
    @Binding var selectedIndex: Int
    let color: Color // Add color parameter

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(options.indices, id: \.self) { idx in
                let option = options[idx]
                let isSelected = idx == selectedIndex
                Button {
                    selectedIndex = idx
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.08))
                            // Preview shape maintaining aspect ratio
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isSelected ? color : Color.gray.opacity(0.5), lineWidth: isSelected ? 2 : 1) // Use color parameter
                                .aspectRatio(option.width / option.height, contentMode: .fit)
                                .frame(height: 36)
                                .padding(8)
                        }
                        .frame(height: 60)

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(option.label)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                if isSelected {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.caption2)
                                        .foregroundColor(color) // Use color parameter
                                }
                            }
                            .padding(.horizontal, 5)

                            // Platform recommendations (first 1 shown)
                            if !option.platforms.isEmpty {
                                HStack(spacing: 4) {
                                    ForEach(option.platforms.prefix(1), id: \.self) { platform in
                                        Text(platform)
                                            .font(.caption2)
                                            .foregroundColor(color) // Use color parameter
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 2)
                                            .background(color.opacity(0.12)) // Use color parameter
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                        .padding(.bottom, 6)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? color : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1) // Use color parameter
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Size Selector

struct SizeSelector: View {
    let options: [SizeOption]
    @Binding var selectedIndex: Int

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    private func aspectRatio(for option: SizeOption) -> CGFloat {
        guard option.heightPx != 0 else { return 1 }
        return CGFloat(option.widthPx) / CGFloat(option.heightPx)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(options.indices, id: \.self) { idx in
                let option = options[idx]
                let isSelected = idx == selectedIndex
                Button {
                    selectedIndex = idx
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.08))
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.5), lineWidth: isSelected ? 2 : 1)
                                .aspectRatio(aspectRatio(for: option), contentMode: .fit)
                                .frame(height: 56)
                                .padding(12)
                        }
                        .frame(height: 86)

                        HStack(spacing: 6) {
                            Text(option.label)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}
