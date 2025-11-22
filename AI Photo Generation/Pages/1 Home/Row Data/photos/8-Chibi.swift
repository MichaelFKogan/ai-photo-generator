//
//  8-Chibi.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/8/25.
//

let chibi = [
    
    InfoPacket(
        title: "Chibi Character",
        cost: 0.05,
        
        imageName: "chibi1",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Convert this image into an ultra-cute chibi character with the following features: The character should have enormous, expressive eyes with thick black outlines, and should lack any other facial features, including the mouth, for a super simplified and adorable look.
        
        For the character's attire keep the design minimalist. The body should be tiny, with very short limbs, accentuating the chibi style's characteristics. 
        
        Place the character against a plain, dark background to ensure it stands out with a stark contrast.
        
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
        title: "Chibi Character",
        cost: 0.05,
        
        imageName: "chibi2",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Convert this image into an ultra-cute chibi character with the following features: The character should have enormous, expressive eyes with thick black outlines, and should lack any other facial features, including the mouth, for a super simplified and adorable look.
        
        For the character's attire keep the design minimalist. The body should be tiny, with very short limbs, accentuating the chibi style's characteristics. 
        
        Place the character against a plain, dark background to ensure it stands out with a stark contrast.
        
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
    
//    InfoPacket(
//        title: "Chibi Character: Hyper-Realistic",
//        cost: 0.05,
//        
//        imageName: "chibirealistic",
//        imageNameOriginal: "yourphoto",
//        
//        description: "",
//        prompt: """
//        
//        Convert this image into a hyper-realistic ultra-cute chibi character with the following features: The character should have enormous, expressive eyes with thick black outlines, and should lack any other facial features, including the mouth, for a super simplified and adorable look.
//        
//        For the character's attire keep the design minimalist. The body should be tiny, with very short limbs, accentuating the chibi style's characteristics. 
//        
//        Place the character against a plain, dark background to ensure it stands out with a stark contrast.
//        
//        """,
//        type: "Photo Filter",
//        
//        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
//        modelName: "Nano Banana",
//        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
//        modelImageName: "",
//        exampleImages: [],  // Add example images here when available
//        
//        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
//        outputFormat: "jpeg",
//        enableSyncMode: false,  // nano-banana uses async mode with polling
//        enableBase64Output: false
//    ),
    
    InfoPacket(
        title: "Funko",
        cost: 0.05,
        
        imageName: "funkobond",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Transform the person in the photo into the style of a Funko Pop figure box, presented in isometric view.
        
        Inside the box, display a chibi-style figure based on the person in the photo, along with their essential accessories.
        
        Next to the box, show a realistic rendering of the actual figure outside the packaging, with detailed textures and lighting to achieve a lifelike product display.
        
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
