//
//  WaveSpeedResponse.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/19/25.
//

import SwiftUI

struct WaveSpeedResponse: Decodable {
    struct DataItem: Decodable {
        let id: String
        let outputs: [String]?
        let status: String
        let error: String?
    }
    let code: Int
    let message: String
    let data: DataItem
}

let apiKey = "5fb599c5eca75157f34d7da3efc734a3422a4b5ae0e6bbf753a09b82e6caebdf"

func sendImageToWaveSpeed(image: UIImage, prompt: String) async throws -> WaveSpeedResponse {
    
//    guard let apiKey = ProcessInfo.processInfo.environment["WAVESPEED_API_KEY"] else {
//        throw URLError(.userAuthenticationRequired)
//    }
    
    // Convert UIImage to JPEG Data, then base64 URL (data URL)
    guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
        throw URLError(.cannotDecodeRawData) // or a custom error
    }
    
    let base64String = jpegData.base64EncodedString()
    let dataURL = "data:image/jpeg;base64,\(base64String)"
    
    let url = URL(string: "https://api.wavespeed.ai/api/v3/google/gemini-2.5-flash-image/edit")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    
    let body: [String: Any] = [
        "prompt": prompt,
        "images": [dataURL],
        "output_format": "jpeg",
        "enable_sync_mode": true,       // synchronous for immediate result
        "enable_base64_output": false   // we will receive a URL
    ]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let wavespeedResponse = try decoder.decode(WaveSpeedResponse.self, from: data)
    
    if wavespeedResponse.data.status != "completed" {
        throw NSError(domain: "WaveSpeedAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: wavespeedResponse.data.error ?? "Unknown error"])
    }
    
    return wavespeedResponse
}
