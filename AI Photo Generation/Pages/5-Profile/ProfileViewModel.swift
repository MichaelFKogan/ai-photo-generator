
import SwiftUI
import Combine
import Supabase

struct UserImage: Codable, Identifiable {
    let id: String
    let image_url: String
    let model: String?
    let title: String?
    let cost: Double?
    let type: String?
    let endpoint: String?
    let created_at: String?
    let media_type: String? // "image" or "video"
    let file_extension: String? // e.g., "jpg", "mp4", "webm"
    let thumbnail_url: String? // Thumbnail for videos
    
    // Computed property for convenience
    var isVideo: Bool {
        media_type == "video"
    }
    
    var isImage: Bool {
        media_type == "image" || media_type == nil
    }
    
    // Custom coding keys to handle database field names
    enum CodingKeys: String, CodingKey {
        case id
        case image_url
        case model
        case title
        case cost
        case type
        case endpoint
        case created_at
        case media_type
        case file_extension
        case thumbnail_url
    }
    
    // Custom decoder to handle id as either Int or String
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Try to decode id as String first, then as Int
        if let idString = try? container.decode(String.self, forKey: .id) {
            self.id = idString
        } else if let idInt = try? container.decode(Int.self, forKey: .id) {
            self.id = String(idInt)
        } else {
            // Fallback to using image_url as id if id is missing
            let url = try container.decode(String.self, forKey: .image_url)
            self.id = url
        }
        
        self.image_url = try container.decode(String.self, forKey: .image_url)
        self.model = try? container.decode(String.self, forKey: .model)
        self.title = try? container.decode(String.self, forKey: .title)
        self.cost = try? container.decode(Double.self, forKey: .cost)
        self.type = try? container.decode(String.self, forKey: .type)
        self.endpoint = try? container.decode(String.self, forKey: .endpoint)
        self.created_at = try? container.decode(String.self, forKey: .created_at)
        self.media_type = try? container.decode(String.self, forKey: .media_type)
        self.file_extension = try? container.decode(String.self, forKey: .file_extension)
        self.thumbnail_url = try? container.decode(String.self, forKey: .thumbnail_url)
    }
}


// MARK: - ViewModel
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userImages: [UserImage] = []
    @Published var isLoading = false
    
    private let client = SupabaseManager.shared.client
    private var hasLoadedOnce = false
    var userId: String? = nil
    
    // ✅ Cache user images persistently between launches
    // Note: Changed key from "cachedUserImages" to "cachedUserImagesV2" after adding metadata support
    @AppStorage("cachedUserImagesV2") private var cachedUserImagesData: Data = Data()
    
    // Convenience computed property for backward compatibility (just URLs)
    var images: [String] {
        userImages.map { $0.image_url }
    }
    
    init() {
        loadCachedImages()
    }
    
    private func loadCachedImages() {
        if let decoded = try? JSONDecoder().decode([UserImage].self, from: cachedUserImagesData) {
            userImages = decoded
            hasLoadedOnce = true
//            print("📦 Loaded cached user images (\(userImages.count))")
        }
    }
    
    private func saveCachedImages() {
        if let encoded = try? JSONEncoder().encode(userImages) {
            cachedUserImagesData = encoded
        }
    }
    
    func fetchUserImages(forceRefresh: Bool = false) async {
        guard let userId = userId else { return }
        guard !hasLoadedOnce || forceRefresh else { return } // ✅ Don't re-fetch unnecessarily
        
        isLoading = true
        
        do {
            let response: PostgrestResponse<[UserImage]> = try await client.database
                .from("user_media")
                .select()
                .eq("user_id", value: userId)
                .order("created_at", ascending: false)
                .execute()
            
            userImages = response.value ?? []
            saveCachedImages()   // ✅ Store new images locally
            hasLoadedOnce = true
//            print("✅ Fetched and cached \(userImages.count) images from Supabase")
            
        } catch {
            print("❌ Failed to fetch user images: \(error)")
        }
        
        isLoading = false
    }
}
