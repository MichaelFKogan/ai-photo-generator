//
//  StreetPhotography.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let streetPhotography = [
    InfoPacket(
        imageName: "urbanmotion",
        imageNameOriginal: "yourphoto",
        
        title: "Urban Motion",
        cost: 0.05,
        description: "",
        prompt: """
        
        CINEMATIC STREET PHOTOGRAPHY, STYLISH YOUNG WOMAN IN MOTION, URBAN ENVIRONMENT, MOTION BLUR EFFECT. BLURRED PEDESTRIANS PASSING BY, SHALLOW DEPTH OF FIELD, NATURAL OVERCAST LIGHTING, SOFT PASTEL TONES, EDITORIAL FASHION PHOTOGRAPHY, CANDID MOMENT, DYNAMIC MOVEMENT, FILM AESTHETIC, MUTED COLORS
            
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
