//
//  NanoBananaTwo.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let nanoBananaTwo = [
    InfoPacket(
        imageName: "neonlitportrait",
        imageNameOriginal: "yourphoto",
        
        title: "Neon-lit Portrait",
        cost: 0.05,
        description: "A futuristic, neon-lit portrait of [SUBJECT_DESCRIPTION], crouching confidently in a moody, [COLOR]-toned room. They hold a large, glowing [NEON_OBJECT_SHAPE] that cuts through the center of the image, casting bright [COLOR] reflections across their skin, outfit, and surroundings. They wear [OUTFIT_DESCRIPTION], blending [STYLE_REFERENCE] with cyberpunk aesthetics. The entire scene is bathed in electric [PRIMARY_COLOR] and deep [SECONDARY_COLOR] lighting, creating a high-contrast, edgy, and surreal atmosphere with a sci-fi fashion vibe.",
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
        imageName: "origami1",
        imageNameOriginal: "yourphoto",
        
        title: "Origami",
        cost: 0.05,
        description: "A detailed origami figure of [CHARACTER] made from brown kraft paper, positioned at a 45-degree angle to the camera in a sitting pose. The figure features clean geometric folding with moderate creases and dimensional layering - not overly complex but showing skilled craftsmanship. Sharp, well-defined edges with some visible fold lines that add structure without appearing wrinkled. The character's eyes are open, large and black with small white highlights for a friendly expression. The paper work shows thoughtful geometric segmentation on the body parts with precise but not excessive folding detail. Warm, soft lighting creates gentle shadows that emphasize the three-dimensional form. Warm brown blurred background, professional photography, 1080x1080 square format, artisanal craft photography style, hyperrealistic detail.",
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
        imageName: "origami2",
        imageNameOriginal: "yourphoto",
        
        title: "Origami",
        cost: 0.05,
        description: "A detailed origami figure of [CHARACTER] made from brown kraft paper, positioned at a 45-degree angle to the camera in a sitting pose. The figure features clean geometric folding with moderate creases and dimensional layering - not overly complex but showing skilled craftsmanship. Sharp, well-defined edges with some visible fold lines that add structure without appearing wrinkled. The character's eyes are open, large and black with small white highlights for a friendly expression. The paper work shows thoughtful geometric segmentation on the body parts with precise but not excessive folding detail. Warm, soft lighting creates gentle shadows that emphasize the three-dimensional form. Warm brown blurred background, professional photography, 1080x1080 square format, artisanal craft photography style, hyperrealistic detail.",
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
        imageName: "coloredpencildrawing",
        imageNameOriginal: "yourphoto",
        
        title: "Colored Pencil Drawing",
        cost: 0.05,
        description: "A colored pencil drawing of [SUBJECT] on brown kraft paper, using soft layering and paper tone for natural midtones, with vibrant highlights and subtle texture.",
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
