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

func sendImageToWaveSpeed(
    
    image: UIImage,
    prompt: String,
    aspectRatio: String? = nil,      // optional, e.g., "1:1", "16:9"
    outputFormat: String = "jpeg",   // "jpeg" or "png"
    enableSyncMode: Bool = true,
    enableBase64Output: Bool = false,
    endpoint: String,
    maxPollingAttempts: Int = 15     // Default 15 for images (30s), use higher for videos
    
) async throws -> WaveSpeedResponse {
    
    //    guard let apiKey = ProcessInfo.processInfo.environment["WAVESPEED_API_KEY"] else {
    //        throw URLError(.userAuthenticationRequired)
    //    }
    
    print("[WaveSpeed] Preparing request…")
    
    // Convert UIImage to JPEG Data, then base64 URL
    guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
        print("[WaveSpeed] Failed to convert UIImage to JPEG data.")
        throw URLError(.cannotDecodeRawData)
    }
    
    let base64String = jpegData.base64EncodedString()
    let dataURL = "data:image/jpeg;base64,\(base64String)"
    
    let url = URL(string: endpoint)!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    
    // Build request body
    var body: [String: Any] = [
        "prompt": prompt,
        "image": dataURL,
        "output_format": outputFormat,
        "enable_sync_mode": enableSyncMode,
        "enable_base64_output": enableBase64Output
    ]
    
    // Only include optional params if they’re set
    if let aspectRatio = aspectRatio {
        body["aspect_ratio"] = aspectRatio
    }
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body)
    
    print("[WaveSpeed] Sending request to API…")
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print("[WaveSpeed] Response received from API.")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("[WaveSpeed] Invalid response object.")
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("[WaveSpeed] HTTP error: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let wavespeedResponse = try decoder.decode(WaveSpeedResponse.self, from: data)
        print("[WaveSpeed] Decoded response. Status: \(wavespeedResponse.data.status)")
        
        
        
        if wavespeedResponse.data.status == "created" {
            print("[WaveSpeed] Job created, polling for completion…")
            let jobId = wavespeedResponse.data.id
            var statusResponse: WaveSpeedResponse
            let pollInterval: UInt64 = 5_000_000_000 // 5 seconds between polls
            print("[WaveSpeed] Will poll up to \(maxPollingAttempts) times (every 5 seconds = \(maxPollingAttempts * 5)s max)")
            
            for attempt in 0..<maxPollingAttempts {
                try await Task.sleep(nanoseconds: pollInterval)
                print("[WaveSpeed] Polling attempt \(attempt + 1)/\(maxPollingAttempts)...")
                statusResponse = try await fetchWaveSpeedJobStatus(id: jobId)
                
                if statusResponse.data.status == "completed" {
                    print("[WaveSpeed] Job completed successfully!")
                    return statusResponse
                } else if statusResponse.data.status == "failed" {
                    throw NSError(domain: "WaveSpeedAPI", code: 2, userInfo: [
                        NSLocalizedDescriptionKey: statusResponse.data.error ?? "WaveSpeed job failed."
                    ])
                } else {
                    print("[WaveSpeed] Status: \(statusResponse.data.status), continuing to poll...")
                }
            }
            throw NSError(domain: "WaveSpeedAPI", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Timed out waiting for generation after \(maxPollingAttempts * 5) seconds."
            ])

        } else if wavespeedResponse.data.status != "completed" {
            print("[WaveSpeed] Error from API: \(wavespeedResponse.data.error ?? "Unknown error")")
            throw NSError(domain: "WaveSpeedAPI", code: 0, userInfo: [
                NSLocalizedDescriptionKey: wavespeedResponse.data.error ?? "Unknown error"
            ])
        }
        
        
        
        if let urlString = wavespeedResponse.data.outputs?.first {
            print("[WaveSpeed] Generated image URL: \(urlString)")
        } else {
            print("[WaveSpeed] No outputs returned from API.")
        }
        
        return wavespeedResponse
        
    } catch {
        print("[WaveSpeed] Network or decoding error: \(error)")
        throw error
    }
}

func fetchWaveSpeedJobStatus(id: String) async throws -> WaveSpeedResponse {
    let url = URL(string: "https://api.wavespeed.ai/api/v3/predictions/\(id)/result")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(WaveSpeedResponse.self, from: data)
}
