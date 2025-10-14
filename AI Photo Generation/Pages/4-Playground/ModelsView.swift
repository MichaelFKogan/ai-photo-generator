import SwiftUI

struct ModelsView: View {
    @State private var selectedTab = 0
    @State private var sortOrder = 0 // 0 = none, 1 = low to high, 2 = high to low
    
    var sortedVideoModels: [Model] {
        switch sortOrder {
        case 1:
            return videoModels.sorted { $0.price < $1.price }
        case 2:
            return videoModels.sorted { $0.price > $1.price }
        default:
            return videoModels
        }
    }
    
    var sortedImageModels: [Model] {
        switch sortOrder {
        case 1:
            return imageModels.sorted { $0.price < $1.price }
        case 2:
            return imageModels.sorted { $0.price > $1.price }
        default:
            return imageModels
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Top Tab Switcher (Video | Image)
                HStack(spacing: 0) {
                    TabHeaderButton(title: "Video", isSelected: selectedTab == 0) {
                        withAnimation { selectedTab = 0 }
                    } label: {
                        Label("Video", systemImage: "video.fill")
                    }

                    TabHeaderButton(title: "Image", isSelected: selectedTab == 1) {
                        withAnimation { selectedTab = 1 }
                    } label: {
                        Label("Image", systemImage: "photo.fill")
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                
                // Price Filter
                HStack {
                    Text("Sort by price:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Menu {
                        Button {
                            withAnimation {
                                sortOrder = 0
                            }
                        } label: {
                            Label("Default", systemImage: sortOrder == 0 ? "checkmark" : "")
                        }
                        
                        Button {
                            withAnimation {
                                sortOrder = 1
                            }
                        } label: {
                            Label("Price Low to High", systemImage: sortOrder == 1 ? "checkmark" : "")
                        }
                        
                        Button {
                            withAnimation {
                                sortOrder = 2
                            }
                        } label: {
                            Label("Price High to Low", systemImage: sortOrder == 2 ? "checkmark" : "")
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(sortOrderText)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Swipeable Content
                TabView(selection: $selectedTab) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack{
                            Text("Video Models")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.top, 8)
                            Spacer()
                            Text("Price per 8s video")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                        ModelGridView(models: sortedVideoModels, modelType: .video)
                    }
                    .tag(0)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack{
                            Text("Image Models")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.top, 8)
                            Spacer()
                            Text("Price per image")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                        ModelGridView(models: sortedImageModels, modelType: .image)
                    }
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("Models")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var sortOrderText: String {
        switch sortOrder {
        case 1:
            return "Low to High"
        case 2:
            return "High to Low"
        default:
            return "Default"
        }
    }
}

struct TabHeaderButton<Label: View>: View {
    let isSelected: Bool
    let action: () -> Void
    let label: Label

    init(title: String, isSelected: Bool, action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.isSelected = isSelected
        self.action = action
        self.label = label()
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                label
                    .fontWeight(isSelected ? .bold : .regular)
                    .foregroundColor(isSelected ? .blue : .gray)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isSelected ? .blue : .clear)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}


struct ModelGridView: View {
    let models: [Model]
    let modelType: ModelType
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(models) { model in
                    NavigationLink(destination: ModelDetailView(model: model, modelType: modelType)) {
                        HStack(alignment: .top, spacing: 12) {
                            // Thumbnail image on the left
                            Image(model.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                            // Model details on the right
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(alignment: .top) {
                                    Text(model.name)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)

                                    Spacer()

                                    // Price badge
                                    Text(String(format: "$%.2f", model.price))
                                        .font(.caption)
//                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.black)
                                        .cornerRadius(6)
                                }

                                Text(model.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(3)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(12)
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 100)
        }
    }
}


