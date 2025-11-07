//
//  LinkedInHeadshotsRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let linkedInHeadshots = [
    InfoPacket(
        title: "LinkedIn Headshot",
        cost: 0.04,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "Transform the existing photo into a high-quality, professional LinkedIn headshot. Be sure to highlight the subject’s natural features (eyes, hair, skin tone, etc) with complimentary true-to-life colors and smooth, even lighting. Dress the subject in modern attire that's polished but approachable (avoid suits, ties, and collared shirts). Use a clean, neutral, quiet city scape background with soft depth of field to keep the focus on the subject while adding a subtle, contemporary look. Frame the image tightly on the head and upper shoulders. Ensure the final image is sharp, well-lit, and conveys confidence, professionalism, and approachability, while retaining the subject's natural features and look.",
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
        title: "Professional Headshot",
        cost: 0.05,
        
        imageName: "headshot1",
        imageNameOriginal: "yourphoto",
        
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
        title: "Professional Headshot",
        cost: 0.05,
        
        imageName: "headshot3",
        imageNameOriginal: "yourphoto",
        
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
        title: "Professional Headshot",
        cost: 0.05,
        
        imageName: "headshot2",
        imageNameOriginal: "yourphoto",
        
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
