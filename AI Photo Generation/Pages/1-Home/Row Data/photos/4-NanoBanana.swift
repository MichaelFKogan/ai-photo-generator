//
//  NanoBanana.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//


let nanoBanana = [
    InfoPacket(
        title: "Cinematic Fusion",
        cost: 0.05,
        
        imageName: "cinematicfusion",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: "A [subject] blending cultural influences, adorned in symbolic armor with engraved patterns, standing in a dramatic setting beneath a moody sky. Cinematic composition, chiaroscuro lighting, sweeping camera angle, authentic film stock color palette, grainy 35mm texture, hyper-detailed, epic atmosphere, captured in a vintage cinematic style.",
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

