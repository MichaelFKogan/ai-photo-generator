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
    @State private var selectedUserImage: UserImage? = nil
    
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
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 3), spacing: 4) {
                                ForEach(0..<9, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.2))
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                                .font(.title3)
                                        )
                                        .aspectRatio(1/1.4, contentMode: .fit) // ✅ portrait ratio (≈0.714)
                                }
                            }
                            .padding(.horizontal)

                        } else {
                            ImageGridView(userImages: viewModel.userImages) { userImage in
                                selectedUserImage = userImage
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
            .sheet(item: $selectedUserImage) { userImage in
                FullScreenImageView(
                    userImage: userImage,
                    isPresented: Binding(
                        get: { selectedUserImage != nil },
                        set: { if !$0 { selectedUserImage = nil } }
                    )
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .ignoresSafeArea()
                .onDisappear {
                    // Refresh the image list when the sheet is dismissed
                    Task {
                        await viewModel.fetchUserImages(forceRefresh: true)
                    }
                }
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
    let userImages: [UserImage]
    let spacing: CGFloat = 2
    var onSelect: (UserImage) -> Void
    
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
                ForEach(userImages) { userImage in
                    if let url = URL(string: userImage.image_url) {
                        Button {
                            onSelect(userImage)
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
        .frame(height: calculateHeight(for: userImages.count))
    }
    
    private func calculateHeight(for count: Int) -> CGFloat {
        let rows = ceil(Double(count) / 3.0)
        let itemWidth = (UIScreen.main.bounds.width - 16) / 3
        return CGFloat(rows) * (itemWidth * 1.8 + spacing)
    }
}

// MARK: - Full Screen Image View
struct FullScreenImageView: View {
    let userImage: UserImage
    @Binding var isPresented: Bool
    @State private var zoom: CGFloat = 1.0
    @State private var showDeleteAlert = false
    @State private var isDeleting = false
    
    var imageURL: URL? {
        URL(string: userImage.image_url)
    }
    
    var isPhotoFilter: Bool {
        userImage.type == "Photo Filter"
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Image section
                if let url = imageURL {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(zoom)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in zoom = value }
                                .onEnded { _ in withAnimation { zoom = 1.0 } }
                        )
                        .frame(maxWidth: .infinity)
                }
                
                // Info section below image
                VStack(alignment: .leading, spacing: 16) {
                    // Header with action buttons
                    HStack {
                        Text("Generation Details")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Share button
                        if let url = imageURL {
                            ShareLink(item: url) {
                                HStack(spacing: 4) {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                        .font(.subheadline)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(8)
                            }
                            .disabled(isDeleting)
                        }
                    }
                    
                    Divider()
                        .background(Color.gray.opacity(0.3))
                    
                    // Display Photo Filter specific information
                    if isPhotoFilter {
                        if let title = userImage.title, !title.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Image(systemName: "paintbrush.fill")
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.blue, .purple],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .font(.caption)
                                    Text("Filter Name")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Text(title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        if let type = userImage.type {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Type")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(type)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                if let cost = userImage.cost {
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("Cost")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("$\(String(format: "%.2f", cost))")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        
                        if let model = userImage.model, !model.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Model")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(model)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                        }
                    } else {
                        // For non-Photo Filter types, show generic info
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .font(.caption)
                                Text("AI Generated")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            if let model = userImage.model, !model.isEmpty {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Model")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(model)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack{
                        
                        // Reuse Model Button (only for Photo Filters)
                        if isPhotoFilter {
                            Button(action: {
                                // TODO: Load this model/preset and navigate to generation view
//                                isPresented = false
                                // You'll need to pass the model parameters back to your generation view
                            }) {
                                HStack {
                                    Image(systemName: "arrow.clockwise")
                                    Text("Use This Filter")
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
                        
                        // Delete button
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "trash.fill")
                                Text("Delete")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .disabled(isDeleting)
                    }
                    .padding(.bottom, 40)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.8))
                
                Spacer()
            }
        }
        .alert("Delete Image?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await deleteImage()
                }
            }
        } message: {
            Text("This will permanently delete this image. This action cannot be undone.")
        }
    }
    
    // MARK: - Delete Image
    private func deleteImage() async {
        isDeleting = true
        
        do {
            let imageUrl = userImage.image_url
            print("🔍 Full image URL: \(imageUrl)")
            
            // Delete from database first
            try await SupabaseManager.shared.client.database
                .from("user_images")
                .delete()
                .eq("id", value: userImage.id)
                .execute()
            
            print("✅ Image record deleted from database")
            
            // Extract the storage path from the URL
            // Try multiple URL formats to find the path
            var storagePath: String?
            
            // Method 1: Look for /user-generated-images/
            if let bucketIndex = imageUrl.range(of: "/user-generated-images/") {
                storagePath = String(imageUrl[bucketIndex.upperBound...])
            }
            // Method 2: Look for /public/user-generated-images/
            else if let publicIndex = imageUrl.range(of: "/public/user-generated-images/") {
                storagePath = String(imageUrl[publicIndex.upperBound...])
            }
            // Method 3: Parse URL components
            else if let url = URL(string: imageUrl) {
                print("🔍 URL components: \(url.pathComponents)")
                // Find "user-generated-images" in path components
                if let bucketIdx = url.pathComponents.firstIndex(of: "user-generated-images") {
                    let pathAfterBucket = url.pathComponents.dropFirst(bucketIdx + 1)
                    storagePath = pathAfterBucket.joined(separator: "/")
                }
            }
            
            if let storagePath = storagePath {
                print("🗑️ Extracted storage path: '\(storagePath)'")
                
                do {
                    // Delete from Supabase Storage
                    let result = try await SupabaseManager.shared.client.storage
                        .from("user-generated-images")
                        .remove(paths: [storagePath])
                    
                    print("✅ Storage deletion result: \(result)")
                    print("✅ Image file deleted from storage successfully")
                } catch {
                    print("❌ Storage deletion error: \(error)")
                    print("❌ Error description: \(error.localizedDescription)")
                    if let nsError = error as NSError? {
                        print("❌ Error domain: \(nsError.domain), code: \(nsError.code)")
                        print("❌ Error userInfo: \(nsError.userInfo)")
                    }
                }
            } else {
                print("⚠️ Could not extract storage path from URL: \(imageUrl)")
            }
            
            // Close the view
            await MainActor.run {
                isPresented = false
            }
            
        } catch {
            print("❌ Failed to delete image: \(error)")
            await MainActor.run {
                isDeleting = false
            }
        }
    }
}

// MARK: - URL Identifiable
extension URL: Identifiable {
    public var id: String { absoluteString }
}
