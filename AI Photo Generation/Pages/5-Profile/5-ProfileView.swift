//
//  ProfileView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI
import Kingfisher

// MARK: - Profile View
struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            if let user = authViewModel.user {
                ProfileViewContent(viewModel: viewModel)
                    .environmentObject(authViewModel)
                    .onAppear {
                        if viewModel.userId != user.id.uuidString {
                            viewModel.userId = user.id.uuidString
                        }
                        Task {
                            print("🔄 Profile appeared, fetching images for user: \(user.id.uuidString)")
                            await viewModel.fetchUserImages(forceRefresh: true)
                            print("📸 Fetched \(viewModel.images.count) images")
                        }
                    }
            } else {
                Text("Loading user…")
            }
        }
    }
}

// MARK: - Profile Content
struct ProfileViewContent: View {
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedImageURL: URL? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Header
//                    profileHeader
                    
//                    // Edit Profile Button
//                    Button(action: {}) {
//                        Text("Edit Profile")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(12)
//                    }
//                    .padding(.horizontal)
                    
                    // My Creations Section
                    VStack(alignment: .leading, spacing: 12) {
//                        Text("My Creations")
//                            .font(.title2)
//                            .fontWeight(.semibold)
//                            .padding(.horizontal)
                        
                        if viewModel.isLoading {
                            ProgressView("Loading images…")
                                .padding()
                        } else if viewModel.images.isEmpty {
                            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 4) {
                                ForEach(0..<9, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.2))
                                        .aspectRatio(1.8, contentMode: .fit)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                                .font(.title3)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            ImageGridView(images: viewModel.images) { url in
                                selectedImageURL = url
                            }
                        }
                    }
                }
                .padding(.top, 10)
//                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("My Creations")
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView().environmentObject(authViewModel)) {
                            Image(systemName: "gearshape.fill")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.fetchUserImages(forceRefresh: true)
            }
            .sheet(item: $selectedImageURL) { imageURL in
                FullScreenImageView(
                    imageURL: imageURL,
                    isPresented: Binding(
                        get: { selectedImageURL != nil },
                        set: { if !$0 { selectedImageURL = nil } }
                    )
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()
            }
        }
    }
    
    // MARK: - Profile Header
    private var profileHeader: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(spacing: 4) {
                    Text("Your Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("@username")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 32) {
                    statView(value: "24", label: "Creations")
                    statView(value: "156", label: "Likes")
                    statView(value: "89", label: "Followers")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .padding(.horizontal)
    }
    
    private func statView(value: String, label: String) -> some View {
        VStack {
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Credits Display
    private var creditsDisplay: some View {
        HStack(spacing: 6) {
            Image(systemName: "diamond.fill")
                .foregroundStyle(
                    LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
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
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.secondary.opacity(0.1)))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                )
        )
    }
}

// MARK: - Image Grid (3×3 Portrait)
struct ImageGridView: View {
    let images: [String]
    let spacing: CGFloat = 2
    var onSelect: (URL) -> Void
    
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: 3)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let totalSpacing = spacing * 2
            let contentWidth = proxy.size.width - totalSpacing - 8
            let itemWidth = contentWidth / 3
            let itemHeight = itemWidth * 1.4
            
            LazyVGrid(columns: gridColumns, spacing: spacing) {
                ForEach(images, id: \.self) { urlString in
                    if let url = URL(string: urlString) {
                        Button {
                            onSelect(url)
                        } label: {
                            KFImage(url)
                                .placeholder {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .overlay(ProgressView())
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth, height: itemHeight)
                                .clipped()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
        .frame(height: calculateHeight(for: images.count))
    }
    
    private func calculateHeight(for count: Int) -> CGFloat {
        let rows = ceil(Double(count) / 3.0)
        let itemWidth = (UIScreen.main.bounds.width - 16) / 3
        return CGFloat(rows) * (itemWidth * 1.8 + spacing)
    }
}

// MARK: - Full Screen Image View
struct FullScreenImageView: View {
    let imageURL: URL
    @Binding var isPresented: Bool
    @State private var zoom: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top spacing to sit below drag indicator
//                Color.clear.frame(height: 20)
                
                // Image section
                KFImage(imageURL)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(zoom)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in zoom = value }
                            .onEnded { _ in withAnimation { zoom = 1.0 } }
                    )
                    .frame(maxWidth: .infinity)
                
                // Info section below image
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Generation Details")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Share button
                        ShareLink(item: imageURL) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    
                    HStack {
                        Label("Anime Style", systemImage: "paintbrush.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Model: SD 1.5")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Steps: 50")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("CFG: 7.5")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Reuse Model Button
                    Button(action: {
                        // TODO: Load this model/preset and navigate to generation view
                        isPresented = false
                        // You'll need to pass the model parameters back to your generation view
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Reuse This Model")
                                .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                    }
                    .padding(.top, 4)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.8))
                
                Spacer()
            }
        }
    }
}

// MARK: - URL Identifiable
extension URL: Identifiable {
    public var id: String { absoluteString }
}
