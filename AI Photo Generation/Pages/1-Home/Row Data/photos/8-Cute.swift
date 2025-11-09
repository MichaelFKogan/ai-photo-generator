//
//  8-Cute.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

let cute = [
    
    InfoPacket(
        title: "Knitted Doll",
        cost: 0.05,
        
        imageName: "knitteddoll",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        A close-up, professionally composed photograph showcasing a hand-crocheted yarn doll gently cradled by two hands. The doll is full body, and has a rounded shape featuring the cute chibi image of the [upload image] character, with vivid contrasting colors rich details. The doll's hair color and clothing are consistent with the provided image.
        
        The hands holding the doll are natural and gentle, with clearly visible finger postures, and natural skin texture and light/shadow transitions, conveying a warm and realistic touch. 
        
        The background is slightly blurred, depicting an indoor environment with a warm wooden tabletop and natural light streaming in from a window, creating a comfortable and intimate atmosphere. 
        
        The overall image conveys a sense of exquisite craftsmanship and cherished warmth.
        
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
        title: "Snow Globe 2",
        cost: 0.05,
        
        imageName: "snowglobe2",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        A delicate snow globe crystal ball rests quietly on a warm, softly lit tabletop by the window. The background is blurred and hazy, with warm-toned sunlight gently passing through the crystal ball, refracting specks of golden light that softly illuminate the dim surroundings.
        
        Inside the crystal ball, a miniature three-dimensional world themed around the provided image, is naturally displayed — a finely detailed, dreamlike 3D scene. All characters and objects are rendered in adorable chibi style, exquisitely crafted and visually charming, with vivid emotional interactions between them.
        
        The overall atmosphere is rich with fantasy elements, full of intricate details and a surreal magical realism texture. The entire scene feels poetic and dreamy, luxurious yet elegant, radiating a gentle, comforting glow — as if imbued with life through the warm play of light and shadow.
        
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
