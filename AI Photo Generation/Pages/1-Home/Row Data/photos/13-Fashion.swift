//
//  13-Fashion.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

let fashion = [
    InfoPacket(
        title: "Magazine Cover",
        cost: 0.05,
        
        imageName: "magazonecover",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
            Convert this image into a magazine cover. The subject is a beautiful woman wearing a pink qipao, adorned with delicate floral accessories on her head and colorful blossoms woven into her hair. 
        
            Around her neck is an elegant white lace collar. One of her hands gently holds several large butterflies. 
        
            The overall photography style features high-definition detail and texture, resembling a fashion magazine cover. 
        
            The word “FASHION DESIGN” is placed at the top center of the image. The background is a minimalist light gray, designed to highlight the subject.
            
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
        title: "Flower Field Portrait",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        USE THE UPLOADED PHOTO AS IDENTITY REFERENCE. Preserve 100% of the face and identity of the person in the photo; do not alter individual appearance. Generate a realistic outdoor portrait of a person standing immersed in a dense field of tall white flowers with organic centers. The flowers must reach shoulder and head height, surrounding the subject closely, so the person appears almost enclosed within the flowers. Some flowers should overlap and blur in the extreme foreground near the lens. Camera depth creates an even natural depth and framing. The subject is wearing a delicate white dress with lace and relaxed fabric details, standing upright and centered with a serene, calm expression, directly facing the camera. Background: filled consistently with tall blooming flowers and a bright blue sky with soft clouds.

        Lighting: warm golden daylight, soft natural sun, highlighting the texture of the flowers and casting gentle illumination on the subject's face and hair. Shadows are subtle, minimal contrast. Camera & composition: vertical 4:5 close-to-medium portrait eye-level perspective, lens between 85mm-105mm full-frame equivalent for soft natural field focus, fading gently. The subject must appear integrally interacted into the flower field, not in front of it. Environment: natural floral meadow, no artificial props, no digital alterations. Negatives: do not change the face or identity, do not add text, logos, or watermarks, no unrealistic alterations to flowers or sky, no distortions in clothing, no empty background without flowers.

        Quality: ultra-realistic, high-resolution editorial portrait, immersive floral atmosphere with natural framing, crisp textures, and luminous tones. Final output in 4K.
            
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
        title: "Celebratory Balloon & Cake Shot",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Prompt A young woman with long wavy dark hair sitting cross-legged on a white bed, smiling softly with eyes closed, holding two sparklers. She wears a light pink blouse with wide flowy sleeves and black shorts, pink manicure. Surrounding her are many metallic rose-gold and pastel pink balloons. Behind her, giant rose-gold balloons spelling '10K' and a transparent balloon with smaller pink balloons inside. In front of her is a pink frosted cake with a satin ribbon around the base and a '10K' topper, sitting on a crystal-decorated cake stand. Next to the cake, a small pink tray with a glass pitcher of orange juice and a filled stemmed glass. Festive, soft lighting, Instagram style, feminine, celebratory atmosphere, pink and rose-gold color theme.
            
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
        title: "Indie Aesthetic Fridge Shot",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Don't change my face and my hairstyle. Person sitting on the floor in front of an open messy fridge, leaning slightly back with relaxed posture, legs open in a casual spread, confident body language, one hand holding a snack near the mouth, the other hand resting on lap with snack bag. Face showing arrogant fashion model expression, sharp gaze, lips slightly parted, candid indie aesthetic. Wearing oversized y2k white shirt with toon illustration, oversize jeans.

        Chill pose, a red snack bag on lap and a piece of snack near the mouth. Fridge interior filled with messy food and drinks (watermelon, yogurt cups, milk cartons, soda cans, cheese packs, colorful boxes). Bright fridge light casting cool bluish tone, contrasting with warm red pants and snack bag. Candid indie photography style, cinematic RAW, high resolution, soft grain, artsy skena vibe. Warm cinematic film tone, golden highlights, creamy whites, deep reds and oranges, cozy indie vibe. Ultra HD photo. Cinematic vibe.

        Do not change face or hair.
            
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
