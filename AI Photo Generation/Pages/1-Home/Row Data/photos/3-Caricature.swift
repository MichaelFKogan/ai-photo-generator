//
//  3DCaricature.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/6/25.
//

let Caricature = [
    InfoPacket(
        title: "3D Caricature",
        cost: 0.05,
        
        imageName: "3dcaricature",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
            """,
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Gemini Flash 2.5 (Nano Banana)",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: ["caricature1", "caricature2", "caricature3", "caricature4",],
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "3D Caricature",
        cost: 0.05,
        
        imageName: "caricature1",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
            """,
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Gemini Flash 2.5 (Nano Banana)",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: ["3dcaricature", "caricature2", "caricature3", "caricature4",],
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "3D Caricature",
        cost: 0.05,
        
        imageName: "caricature2",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
            """,
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: ["caricature1", "3dcaricature", "caricature3", "caricature4",],
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "3D Caricature",
        cost: 0.05,
        
        imageName: "caricature3",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
            """,
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: ["caricature1", "caricature2", "3dcaricature", "caricature4",],
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "3D Caricature",
        cost: 0.05,
        
        imageName: "caricature4",
        imageNameOriginal: "yourphoto",
        
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
            """,
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: ["caricature1", "caricature2", "caricature3", "3dcaricature",],
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
]
