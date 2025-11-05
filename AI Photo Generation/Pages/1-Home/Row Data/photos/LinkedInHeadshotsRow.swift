//
//  LinkedInHeadshotsRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let linkedInHeadshots = [
    InfoPacket(
        imageName: "headshot1",
        imageNameOriginal: "yourphoto",
        
        title: "Professional Headshot",
        cost: 0.05,
        description: "",
        prompt: """
        
        Create a professional corporate headshot from the uploaded image. Adjust lighting to soft, even studio lighting with no harsh shadows. Retouch skin naturally (remove blemishes, smooth but not plastic). Sharpen facial details while keeping a natural look. Dress the subject in a fitted business white shirt. Use a clean neutral background (light grey or soft gradient). Ensure the final result has a polished, confident, and professional appearance suitable for LinkedIn or corporate profiles.
            
        """,
        
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "headshot3",
        imageNameOriginal: "yourphoto",
        
        title: "Professional Headshot",
        cost: 0.05,
        description: "",
        prompt: """
        
        Create a professional corporate headshot from the uploaded image. Adjust lighting to soft, even studio lighting with no harsh shadows. Retouch skin naturally (remove blemishes, smooth but not plastic). Sharpen facial details while keeping a natural look. Dress the subject in a fitted business white shirt. Use a clean neutral background (light grey or soft gradient). Ensure the final result has a polished, confident, and professional appearance suitable for LinkedIn or corporate profiles.
            
        """,
        
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "headshot2",
        imageNameOriginal: "yourphoto",
        
        title: "Professional Headshot",
        cost: 0.05,
        description: "",
        prompt: """
        
        Create a professional corporate headshot from the uploaded image. Adjust lighting to soft, even studio lighting with no harsh shadows. Retouch skin naturally (remove blemishes, smooth but not plastic). Sharpen facial details while keeping a natural look. Dress the subject in a fitted business white shirt. Use a clean neutral background (light grey or soft gradient). Ensure the final result has a polished, confident, and professional appearance suitable for LinkedIn or corporate profiles.
            
        """,
        
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    
]
