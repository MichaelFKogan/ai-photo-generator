//
//  ProfileView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI
import Kingfisher
import Photos
import AVKit

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
            let contentWidth = max(0, proxy.size.width - totalSpacing - 8)
            let itemWidth = max(44, contentWidth / 3) // minimum thumbnail size
            let itemHeight = itemWidth * 1.4
            
            LazyVGrid(columns: gridColumns, spacing: spacing) {
                ForEach(userImages) { userImage in
                    if let displayUrl = userImage.isVideo ? userImage.thumbnail_url : userImage.image_url,
                       let url = URL(string: displayUrl) {
                        Button {
                            onSelect(userImage)
                        } label: {
                            ZStack {
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
                                
                                // Video play icon overlay
                                if userImage.isVideo {
                                    ZStack {
                                        Circle()
                                            .fill(Color.black.opacity(0.6))
                                            .frame(width: 40, height: 40)
                                        
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    } else if let url = URL(string: userImage.image_url) {
                        // Fallback for videos without thumbnails
                        Button {
                            onSelect(userImage)
                        } label: {
                            ZStack {
                                KFImage(url)
                                    .placeholder {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                            .overlay(
                                                Image(systemName: "video.fill")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.gray)
                                            )
                                    }
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: itemWidth, height: itemHeight)
                                    .clipped()
                                
                                if userImage.isVideo {
                                    ZStack {
                                        Circle()
                                            .fill(Color.black.opacity(0.6))
                                            .frame(width: 40, height: 40)
                                        
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
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
    @State private var isDownloading = false
    @State private var showDownloadConfirmation = false
    @State private var showDownloadResultAlert = false
    @State private var downloadAlertMessage = ""
    @State private var player: AVPlayer?
    
    var mediaURL: URL? {
        URL(string: userImage.image_url)
    }
    
    var thumbnailURL: URL? {
        if let thumbnail = userImage.thumbnail_url {
            return URL(string: thumbnail)
        }
        return nil
    }
    
    var isVideo: Bool {
        userImage.isVideo
    }
    
    var isPhotoFilter: Bool {
        userImage.type == "Photo Filter"
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 0) {
                    // Media section (image or video)
                    if isVideo {
                        // Video player
                        if let url = mediaURL {
                             VideoPlayer(player: player)
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: .infinity)
                                 .onAppear {
                                     player = AVPlayer(url: url)
                                     player?.play()
                                 }
                                 .onDisappear {
                                     player?.pause()
                                     player = nil
                                 }
                         }
                    } else {
                        // Image viewer
                        if let url = mediaURL {
                           KFImage(url)
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(maxWidth: .infinity)
                               .clipped()
                               .scaleEffect(zoom)
                               .gesture(
                                   MagnificationGesture()
                                       .onChanged { value in zoom = value }
                                       .onEnded { _ in withAnimation { zoom = 1.0 } }
                               )
                       }
                    }
                    
                    // Info section below image
                    VStack(alignment: .leading, spacing: 16) {
                        // Header with action buttons
                        HStack {
                            Text("Generation Details")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                // Download button
                                Button(action: {
                                    showDownloadConfirmation = true
                                }) {
                                    HStack(spacing: 4) {
                                        if isDownloading {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                .scaleEffect(0.8)
                                        } else {
                                            Image(systemName: "arrow.down.circle")
                                            Text("Download")
                                                .font(.subheadline)
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.3))
                                    .cornerRadius(8)
                                }
                                .disabled(isDeleting || isDownloading)
                            }
                        }
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                        
                        // Display media type badge
                        HStack {
                            HStack(spacing: 4) {
                                Image(systemName: isVideo ? "video.fill" : "photo.fill")
                                    .font(.caption)
                                Text(isVideo ? "Video" : "Image")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(isVideo ? Color.purple.opacity(0.3) : Color.blue.opacity(0.3))
                            )
                            
                            if let ext = userImage.file_extension {
                                Text(ext.uppercased())
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        
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
                            
                            //                        // Animate button
                            //                        HStack(spacing: 4) {
                            //                            Image(systemName: "video.fill")
                            //                            Text("Animate This Image")
                            //                                .fontWeight(.semibold)
                            //                        }
                            //                        .font(.subheadline)
                            //                        .foregroundColor(.white)
                            //                        .frame(maxWidth: .infinity)
                            //                        .padding(.vertical, 12)
                            //                        .background(Color.green.opacity(0.3))
                            //                        .cornerRadius(10)
                            //
                            //
                            //                        // Reuse Model Button (only for Photo Filters)
                            //                        if isPhotoFilter {
                            //                            Button(action: {
                            //                                // TODO: Load this model/preset and navigate to generation view
                            ////                                isPresented = false
                            //                                // You'll need to pass the model parameters back to your generation view
                            //                            }) {
                            //                                HStack {
                            //                                    Image(systemName: "arrow.clockwise")
                            //                                    Text("Use This Filter")
                            //                                        .fontWeight(.semibold)
                            //                                }
                            //                                .font(.subheadline)
                            //                                .foregroundColor(.white)
                            //                                .frame(maxWidth: .infinity)
                            //                                .padding(.vertical, 12)
                            //                                .background(
                            //                                    LinearGradient(
                            //                                        colors: [.blue, .purple],
                            //                                        startPoint: .leading,
                            //                                        endPoint: .trailing
                            //                                    )
                            //                                )
                            //                                .cornerRadius(10)
                            //                            }
                            //                        }
                            
                            // Share button
                            if let url = mediaURL {
                                ShareLink(item: url) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Share")
                                            .fontWeight(.semibold)
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color.purple.opacity(0.3))
                                    .cornerRadius(10)
                                }
                                .disabled(isDeleting || isDownloading)
                            }
                            
                            // Delete button
                            Button(action: {
                                showDeleteAlert = true
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "trash.fill")
                                    Text("Delete")
                                        .fontWeight(.semibold)
                                }
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
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
        }
        .alert("Delete Image?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await deleteImage()
                }
            }
        } message: {
            Text("This will permanently delete this \(isVideo ? "video" : "image"). This action cannot be undone.")
        }
        .alert("Save to Photos?", isPresented: $showDownloadConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                Task {
                    await downloadImage()
                }
            }
        } message: {
            Text("Do you want to save this \(isVideo ? "video" : "image") to your photo library?")
        }
        .alert("Download", isPresented: $showDownloadResultAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(downloadAlertMessage)
        }
    }
    
    // MARK: - Download Media (Image or Video)
    private func downloadImage() async {
        guard let url = mediaURL else {
            await MainActor.run {
                downloadAlertMessage = "Invalid image URL"
                showDownloadResultAlert = true
            }
            return
        }
        
        await MainActor.run {
            isDownloading = true
        }
        
        do {
            // Download the media data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Request photo library permission and save
            let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
            
            guard status == .authorized || status == .limited else {
                await MainActor.run {
                    isDownloading = false
                    downloadAlertMessage = "Photo library access is required to save media. Please enable it in Settings."
                    showDownloadResultAlert = true
                }
                return
            }
            
            if isVideo {
                // Save video to photo library
                // Write to temporary file first
                let tempURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(UUID().uuidString)
                    .appendingPathExtension(userImage.file_extension ?? "mp4")
                
                try data.write(to: tempURL)
                
                // Save to photo library
                try await PHPhotoLibrary.shared().performChanges {
                    PHAssetCreationRequest.creationRequestForAssetFromVideo(atFileURL: tempURL)
                }
                
                // Clean up temp file
                try? FileManager.default.removeItem(at: tempURL)
                
                print("✅ Video saved to photo library successfully")
            } else {
                // Save image to photo library
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "DownloadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create image from data"])
                }
                
                try await PHPhotoLibrary.shared().performChanges {
                    PHAssetCreationRequest.creationRequestForAsset(from: image)
                }
                
                print("✅ Image saved to photo library successfully")
            }
            
            await MainActor.run {
                isDownloading = false
                downloadAlertMessage = isVideo ? "Video saved to your photo library!" : "Image saved to your photo library!"
                showDownloadResultAlert = true
            }
            
        } catch {
            print("❌ Failed to download media: \(error)")
            await MainActor.run {
                isDownloading = false
                downloadAlertMessage = "Failed to save \(isVideo ? "video" : "image"): \(error.localizedDescription)"
                showDownloadResultAlert = true
            }
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
                .from("user_media")
                .delete()
                .eq("id", value: userImage.id)
                .execute()
            
            print("✅ Image record deleted from database")
            
            // Determine which storage bucket to use
            let bucketName = isVideo ? "user-generated-videos" : "user-generated-images"
            let bucketPath = isVideo ? "/user-generated-videos/" : "/user-generated-images/"
            
            // Extract the storage path from the URL
            // Try multiple URL formats to find the path
            var storagePath: String?
            
            // Method 1: Look for bucket path
            if let bucketIndex = imageUrl.range(of: bucketPath) {
                storagePath = String(imageUrl[bucketIndex.upperBound...])
            }
            // Method 2: Look for /public/bucket/
            else if let publicIndex = imageUrl.range(of: "/public\(bucketPath)") {
                storagePath = String(imageUrl[publicIndex.upperBound...])
            }
            // Method 3: Parse URL components
            else if let url = URL(string: imageUrl) {
                print("🔍 URL components: \(url.pathComponents)")
                // Find bucket name in path components
                let bucketComponent = isVideo ? "user-generated-videos" : "user-generated-images"
                if let bucketIdx = url.pathComponents.firstIndex(of: bucketComponent) {
                    let pathAfterBucket = url.pathComponents.dropFirst(bucketIdx + 1)
                    storagePath = pathAfterBucket.joined(separator: "/")
                }
            }
            
            // Also delete thumbnail if it's a video
            if isVideo, let thumbnailUrl = userImage.thumbnail_url {
                print("🗑️ Also deleting video thumbnail: \(thumbnailUrl)")
                
                var thumbnailPath: String?
                if let bucketIndex = thumbnailUrl.range(of: "/user-generated-images/") {
                    thumbnailPath = String(thumbnailUrl[bucketIndex.upperBound...])
                }
                
                if let thumbnailPath = thumbnailPath {
                    do {
                        let result = try await SupabaseManager.shared.client.storage
                            .from("user-generated-images")
                            .remove(paths: [thumbnailPath])
                        print("✅ Thumbnail deleted: \(result)")
                    } catch {
                        print("❌ Thumbnail deletion error: \(error)")
                    }
                }
            }
            
            if let storagePath = storagePath {
                print("🗑️ Extracted storage path: '\(storagePath)' from bucket: \(bucketName)")
                
                do {
                    // Delete from Supabase Storage
                    let result = try await SupabaseManager.shared.client.storage
                        .from(bucketName)
                        .remove(paths: [storagePath])
                    
                    print("✅ Storage deletion result: \(result)")
                    print("✅ \(isVideo ? "Video" : "Image") file deleted from storage successfully")
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
