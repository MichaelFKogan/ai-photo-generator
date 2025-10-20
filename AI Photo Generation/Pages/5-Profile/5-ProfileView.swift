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
                        // Set userId if needed, then refresh images every time view appears
                        if viewModel.userId != user.id.uuidString {
                            viewModel.userId = user.id.uuidString
                        }
                        Task {
                            print("🔄 Profile appeared, fetching images for user: \(user.id.uuidString)")
                            await viewModel.fetchUserImages(forceRefresh: true)
                            print("📸 Fetched \(viewModel.images.count) images")
                            print("🖼️ Image URLs: \(viewModel.images)")
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
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Profile Header
                    profileHeader
                    
                    // Edit Profile Button
                    Button(action: {}) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // User Creations Grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Creations")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        if viewModel.isLoading {
                            Text("Loading images…")
                                .foregroundColor(.gray)
                                .padding()
                        } else if viewModel.images.isEmpty {
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(0..<9, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.2))
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                                .font(.title3)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(viewModel.images, id: \.self) { urlString in
                                    if let url = URL(string: urlString) {
                                        Button {
                                            selectedImageURL = url
                                        } label: {
                                            KFImage(url)
                                                .placeholder {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(Color.gray.opacity(0.2))
                                                        .aspectRatio(1, contentMode: .fit)
                                                        .overlay(
                                                            ProgressView()
                                                                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                                        )
                                                }
                                                .retry(maxCount: 2, interval: .seconds(2))
                                                .onFailure { error in
                                                    print("❌ Failed to load image: \(error.localizedDescription)")
                                                }
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity)
                                                .aspectRatio(1, contentMode: .fill)
                                                .clipped()
                                                .cornerRadius(8)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle("Profile")
                .toolbar {
                    // 💎 Credits display
                    ToolbarItem(placement: .navigationBarTrailing) {
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
                                .strokeBorder(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        )
                    }
                    // ✅ Settings button
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
                print("🔄 Manual refresh triggered")
                await viewModel.fetchUserImages(forceRefresh: true)
                print("📸 After refresh: \(viewModel.images.count) images")
            }
            .fullScreenCover(item: $selectedImageURL) { imageURL in
                FullScreenImageView(imageURL: imageURL, isPresented: Binding(
                    get: { selectedImageURL != nil },
                    set: { if !$0 { selectedImageURL = nil } }
                ))
            }
        }
    }
    
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
                    VStack {
                        Text("24")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Creations")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    VStack {
                        Text("156")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Likes")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    VStack {
                        Text("89")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .padding(.horizontal)
    }
}

struct FullScreenImageView: View {
    let imageURL: URL
    @Binding var isPresented: Bool
    
    @State private var zoom: CGFloat = 1.0
    @State private var uiImage: UIImage? = nil
    @State private var showShareSheet = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            KFImage(imageURL)
                .onFailure { error in
                    print("❌ Full screen image failed to load: \(error.localizedDescription)")
                }
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(zoom)
                .gesture(MagnificationGesture()
                    .onChanged { value in zoom = value }
                    .onEnded { _ in
                        withAnimation { zoom = 1.0 }
                    }
                )
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

// Make URL conform to Identifiable for item-based presentation
extension URL: Identifiable {
    public var id: String { self.absoluteString }
}
