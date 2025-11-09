//
//  texttoimage.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let imageModelsRow = [

    InfoPacket(
        title: "Google Nano Banana",
        cost: 0.05,
        
        imageName: "geminiflashimage25",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Gemini Flash 2.5 / Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "geminiflashimage25",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),

    InfoPacket(
        title: "GPT Image 1",
        cost: 0.15,
        
        imageName: "gptimage1",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "GPT Image 1",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "gptimage1",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    
    InfoPacket(
        title: "Seedream 4.0",
        cost: 0.04,
        
        imageName: "seedream40",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Seedream 4.0",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "seedream40",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),

    InfoPacket(
        title: "FLUX.1 Kontext [dev]",
        cost: 0.04,
        
        imageName: "fluxkontextdev",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [dev]",
        modelDescription: "",
        modelImageName: "fluxkontextdev",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    
    InfoPacket(
        title: "FLUX.1 Kontext [pro]",
        cost: 0.08,
        
        imageName: "fluxkontextpro",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [pro]",
        modelDescription: "",
        modelImageName: "fluxkontextpro",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),

    InfoPacket(
        title: "FLUX.1 Kontext [max]",
        cost: 0.12,
        
        imageName: "fluxkontextmax",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "",
        type: "AI Image Model",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [max]",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "fluxkontextmax",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),

]
