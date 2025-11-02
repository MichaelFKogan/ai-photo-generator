//
//  SupabaseManager.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import Foundation
import Supabase
import UIKit

class SupabaseManager {
    static let shared = SupabaseManager()
    
    // Replace with your actual Supabase URL and anon key
    let client: SupabaseClient
    
    // Name of your storage bucket (you'll need to create this in Supabase dashboard)
    private let storageBucket = "user-generated-images"
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://inaffymocuppuddsewyq.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImluYWZmeW1vY3VwcHVkZHNld3lxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2MTQwMDgsImV4cCI6MjA3NjE5MDAwOH0.rsklD7VpItxb2UTCzH1RPYD8HWKpFifekJaUi8JYkNY"
        )
    }
    
    /// Uploads an image to Supabase Storage and returns the public URL
    /// - Parameters:
    ///   - image: The UIImage to upload
    ///   - userId: The user's ID for organizing files
    ///   - modelName: The AI model name used for generation
    /// - Returns: The public URL of the uploaded image in Supabase Storage
    func uploadImage(image: UIImage, userId: String, modelName: String) async throws -> String {
        // Convert UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
            throw NSError(domain: "ImageError", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG"])
        }
        
        // Create unique filename: userId/timestamp_modelName.jpg
        let timestamp = Int(Date().timeIntervalSince1970)
        let sanitizedModelName = modelName.replacingOccurrences(of: " ", with: "-")
                                          .replacingOccurrences(of: "/", with: "-")
        let filename = "\(userId)/\(timestamp)_\(sanitizedModelName).jpg"
        
        print("[Storage] Uploading image to: \(storageBucket)/\(filename)")
        
        // Upload to Supabase Storage
        let uploadResponse = try await client.storage
            .from(storageBucket)
            .upload(
                path: filename,
                file: imageData,
                options: FileOptions(
                    contentType: "image/jpeg",
                    upsert: false
                )
            )
        
        print("[Storage] Upload successful: \(uploadResponse)")
        
        // Get the public URL for the uploaded file
        let publicURL = try client.storage
            .from(storageBucket)
            .getPublicURL(path: filename)
        
        print("[Storage] Public URL: \(publicURL)")
        
        return publicURL.absoluteString
    }
    
    /// Downloads an image from a URL and uploads it to Supabase Storage
    /// - Parameters:
    ///   - urlString: The URL of the image to download
    ///   - userId: The user's ID
    ///   - modelName: The AI model name
    /// - Returns: The Supabase Storage public URL
    func downloadAndUploadImage(from urlString: String, userId: String, modelName: String) async throws -> String {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "URLError", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        // Download the image
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageError", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to decode image"])
        }
        
        // Upload to Supabase Storage
        return try await uploadImage(image: image, userId: userId, modelName: modelName)
    }
}
