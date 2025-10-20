
import SwiftUI
import Combine
import Supabase

struct UserImage: Decodable {
    let image_url: String
}


// MARK: - ViewModel
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var images: [String] = []
    @Published var isLoading = false
    
    private let client = SupabaseManager.shared.client
    private var hasLoadedOnce = false
    var userId: String? = nil
    
    // ✅ Cache image URLs persistently between launches
    @AppStorage("cachedUserImages") private var cachedUserImagesData: Data = Data()
    
    init() {
        loadCachedImages()
    }
    
    private func loadCachedImages() {
        if let decoded = try? JSONDecoder().decode([String].self, from: cachedUserImagesData) {
            images = decoded
            hasLoadedOnce = true
            print("📦 Loaded cached user images (\(images.count))")
        }
    }
    
    private func saveCachedImages() {
        if let encoded = try? JSONEncoder().encode(images) {
            cachedUserImagesData = encoded
        }
    }
    
    func fetchUserImages(forceRefresh: Bool = false) async {
        guard let userId = userId else { return }
        guard !hasLoadedOnce || forceRefresh else { return } // ✅ Don’t re-fetch unnecessarily
        
        isLoading = true
        
        do {
            let response: PostgrestResponse<[UserImage]> = try await client.database
                .from("user_images")
                .select()
                .eq("user_id", value: userId)
                .order("created_at", ascending: false)
                .execute()
            
            images = response.value.map { $0.image_url } ?? []
            saveCachedImages()   // ✅ Store new images locally
            hasLoadedOnce = true
            print("✅ Fetched and cached \(images.count) images from Supabase")
            
        } catch {
            print("❌ Failed to fetch user images: \(error)")
        }
        
        isLoading = false
    }
}
