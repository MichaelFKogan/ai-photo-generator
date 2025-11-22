//
//  MensFashion.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

let mensfashion = [
    
    InfoPacket(
        title: "Cinematic Street Portrait",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Ultra-realistic cinematic street portrait in a narrow European city street, tall stone buildings, blurred storefronts, pedestrians as soft silhouettes. Subject standing in middle of street, slightly angled, confident gaze. Wearing black overcoat + black scarf, minimal stylish vibe. Lighting: overcast daylight, smooth shadows, balanced contrast. Color grading: cinematic teal-orange, soft desaturated background, natural skin tones. Camera: DSLR 85mm lens, f/1.8, medium waist-up shot, vertical 4:5. Style: cinematic editorial, modern, confident, timeless magazine look.
        
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
        title: "Billionaire Vibe Car Shot",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Make my photo overhead high angle 3:4 full-body shot of a man (preserve face 100%) standing relaxed on the hood of a white Lamborghini Urus in a dim basement garage. Wearing a crisp white open collar shirt, brown trousers, polished shoes, and a leather strap watch. Soft sunbeam lighting with natural reflections on car, cinematic warm color grading, shallow depth of field, creamy bokeh, hyper-realistic 8K detail, billionaire vibe.
        
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
        title: "Black and White Mysterious Portrait",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        A hyper-realistic and minimalist black-and-white portrait of a man (based on the uploaded reference), partially covering his face with his hand. The expression is intense and mysterious. Dramatic lighting creates strong shadows with Photorealistic cinematic vertical portrait (9:16).
        
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
        title: "Black and White Editorial Portrait",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Black and white artistic portrait of a man, with a fashionable model dressed in a sophisticated suit, black socks and shoes. He is sitting with a slightly hunched posture, looking down as if lost in thought. His facial features are the same as the original photo, like her hairstyle. It features minimalist accessories that highlight the elegant and editorial tone. The studio's clean lighting enhances textures and depth, creating an elegant, couture feel. Use the uploaded picture as reference for the face. Aspect ration: 4:5 vertical.
        
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
