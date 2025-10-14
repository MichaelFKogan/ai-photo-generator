//import SwiftUI
//
//struct ModelsView: View {
//    @State private var selectedTab = 0
//    @State private var sortOrder = 0 // 0 = none, 1 = low to high, 2 = high to low
//    
//    var sortedVideoModels: [Model] {
//        switch sortOrder {
//        case 1:
//            return videoModels.sorted { $0.price < $1.price }
//        case 2:
//            return videoModels.sorted { $0.price > $1.price }
//        default:
//            return videoModels
//        }
//    }
//    
//    var sortedImageModels: [Model] {
//        switch sortOrder {
//        case 1:
//            return imageModels.sorted { $0.price < $1.price }
//        case 2:
//            return imageModels.sorted { $0.price > $1.price }
//        default:
//            return imageModels
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                // Custom Tab Bar
//                HStack(spacing: 0) {
//                    TabHeaderButton(title: "Video", isSelected: selectedTab == 0) {
//                        withAnimation {
//                            selectedTab = 0
//                        }
//                    }
//                    
//                    TabHeaderButton(title: "Image", isSelected: selectedTab == 1) {
//                        withAnimation {
//                            selectedTab = 1
//                        }
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top, 8)
//                
//                // Price Filter
//                HStack {
//                    Text("Sort by price:")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    
//                    Spacer()
//                    
//                    Menu {
//                        Button {
//                            withAnimation {
//                                sortOrder = 0
//                            }
//                        } label: {
//                            Label("Default", systemImage: sortOrder == 0 ? "checkmark" : "")
//                        }
//                        
//                        Button {
//                            withAnimation {
//                                sortOrder = 1
//                            }
//                        } label: {
//                            Label("Low to High", systemImage: sortOrder == 1 ? "checkmark" : "")
//                        }
//                        
//                        Button {
//                            withAnimation {
//                                sortOrder = 2
//                            }
//                        } label: {
//                            Label("High to Low", systemImage: sortOrder == 2 ? "checkmark" : "")
//                        }
//                    } label: {
//                        HStack(spacing: 4) {
//                            Text(sortOrderText)
//                                .font(.subheadline)
//                                .fontWeight(.medium)
//                            Image(systemName: "chevron.down")
//                                .font(.caption)
//                        }
//                        .foregroundColor(.blue)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 8)
//                
//                // Swipeable Content
//                TabView(selection: $selectedTab) {
//                    ModelGridView(models: sortedVideoModels)
//                        .tag(0)
//                    
//                    ModelGridView(models: sortedImageModels)
//                        .tag(1)
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//            }
//            .navigationTitle("Models")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//    
//    var sortOrderText: String {
//        switch sortOrder {
//        case 1:
//            return "Low to High"
//        case 2:
//            return "High to Low"
//        default:
//            return "Default"
//        }
//    }
//}
//
//struct TabHeaderButton: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(spacing: 8) {
//                Text(title)
//                    .font(.headline)
//                    .fontWeight(isSelected ? .semibold : .regular)
//                    .foregroundColor(isSelected ? .primary : .secondary)
//                
//                Rectangle()
//                    .fill(isSelected ? Color.blue : Color.clear)
//                    .frame(height: 3)
//            }
//        }
//        .frame(maxWidth: .infinity)
//    }
//}
//
//struct ModelGridView: View {
//    let models: [Model]
//    
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 20) {
//                ForEach(models) { model in
//                    VStack(alignment: .leading, spacing: 8) {
//                        ZStack(alignment: .topTrailing) {
//                            GeometryReader { geometry in
//                                Image(model.imageName)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: geometry.size.width, height: geometry.size.height)
//                                    .clipped()
//                            }
//                            .aspectRatio(0.7, contentMode: .fit)
//                            
//                            // Price badge
//                            Text(String(format: "$%.2f", model.price))
//                                .font(.caption)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 4)
//                                .background(Color.blue)
//                                .cornerRadius(8)
//                                .padding(8)
//                        }
//                        .cornerRadius(12)
//                        .shadow(radius: 4)
//                        
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text(model.name)
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.primary)
//                                .lineLimit(2)
//                            
//                            Text(model.description)
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                                .lineLimit(3)
//                        }
//                    }
//                }
//            }
//            .padding(.horizontal)
//            .padding(.top, 8)
//            .padding(.bottom, 100)
//        }
//    }
//}
//
//
