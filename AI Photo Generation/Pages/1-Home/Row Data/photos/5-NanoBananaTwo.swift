//
//  NanoBananaTwo.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let nanoBananaTwo = [

    InfoPacket(
        title: "Neon-lit Portrait",
        cost: 0.05,
        
        imageName: "neonlitportrait",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "A futuristic, neon-lit portrait of [SUBJECT_DESCRIPTION], crouching confidently in a moody, [COLOR]-toned room. They hold a large, glowing [NEON_OBJECT_SHAPE] that cuts through the center of the image, casting bright [COLOR] reflections across their skin, outfit, and surroundings. They wear [OUTFIT_DESCRIPTION], blending [STYLE_REFERENCE] with cyberpunk aesthetics. The entire scene is bathed in electric [PRIMARY_COLOR] and deep [SECONDARY_COLOR] lighting, creating a high-contrast, edgy, and surreal atmosphere with a sci-fi fashion vibe.",
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
        title: "Crystal Hybrid",
        cost: 0.05,
        
        imageName: "black",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Create a “Crystal-Slime Hybrid Chibi” version of the person in the uploaded photo, while clearly preserving their real identity.

        Identity Preservation
            Maintain the person's actual face shape, nose, eyes, lips, jawline, hair style, and skin tone cues
            Use stylization only for material and chibi proportions — do not replace the person with a creature
            Eyes should remain recognizable to the real person (style them, do not invent new eyes)
            Preserve overall likeness, expression, and unique traits

        Chibi / Material Style
            Cute chibi body with slightly oversized head (not extreme)
            Semi-transparent crystal-glass outer shell with glowing slime core
            Glossy refractive surface with soft rainbow diffraction
            Glitter particles + micro-bubbles inside slime
            Crystal accents integrated naturally (e.g., hair ornament, cheeks, shoulders), not horns unless person already wears something similar
            Emissive aura, soft magical glow

        Color & Accessories
            Use colors inspired by the person's clothing or personal style in the photo
            If they have any accessory (earrings, glasses, hat), reinterpret it in crystal form

        Rendering & Camera
            Soft studio lighting with rim highlights
            Volumetric glow inside body
            Shallow DOF, tack-sharp focus on eyes
            Macro detail, photorealistic PBR materials

        Rules
            Do NOT transform the face into a non-human character
            Do NOT add fantasy horns/spikes unless they resemble accessories in the photo
            Keep pose similar to the photo unless instructed otherwise
        
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
        title: "Cartoon Drip",
        cost: 0.05,
        
        imageName: "black",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Analyze the uploaded image and identify the main subject before transforming it.
        
        Transform the main subject in the uploaded photo into a bold, colorful cartoon illustration style, while keeping the rest of the photo realistic and untouched.

        Main subject rules:

        If the photo contains a clear primary object (e.g., a car, bag, animal, food, product), apply the effect to that object.

        If no distinct object is present and the main subject is a person, apply the cartoon drip effect to the person.

        If multiple subjects exist, choose the most central or visually dominant one.

        Never apply the cartoon drips to the entire image — only the primary subject.

        Cartoon style:

        Thick black outlines

        Vibrant flat colors (cyan, magenta, yellow, hot pink, neon accents)

        Paint drips and splash effects primarily flowing downward

        Slight melting / dripping effect blending into the real photo

        Pop-art energy with a surreal contrast between realism and cartoon

        Keep the background and any secondary subjects completely photorealistic.

        High-resolution output, clean edges, realistic lighting interaction between cartoon subject and real photo.
        
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
        title: "Origami",
        cost: 0.05,
        
        imageName: "origami1",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "A detailed origami figure of [CHARACTER] made from brown kraft paper, positioned at a 45-degree angle to the camera in a sitting pose. The figure features clean geometric folding with moderate creases and dimensional layering - not overly complex but showing skilled craftsmanship. Sharp, well-defined edges with some visible fold lines that add structure without appearing wrinkled. The character's eyes are open, large and black with small white highlights for a friendly expression. The paper work shows thoughtful geometric segmentation on the body parts with precise but not excessive folding detail. Warm, soft lighting creates gentle shadows that emphasize the three-dimensional form. Warm brown blurred background, professional photography, 1080x1080 square format, artisanal craft photography style, hyperrealistic detail.",
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
        title: "Origami",
        cost: 0.05,
        
        imageName: "origami2",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """

        A detailed origami figure of [CHARACTER] made from brown kraft paper, positioned at a 45-degree angle to the camera in a sitting pose. 
        
        The figure features clean geometric folding with moderate creases and dimensional layering - not overly complex but showing skilled craftsmanship. Sharp, well-defined edges with some visible fold lines that add structure without appearing wrinkled. 
        
        The character's eyes are open, large and black with small white highlights for a friendly expression. The paper work shows thoughtful geometric segmentation on the body parts with precise but not excessive folding detail. 
        
        Warm, soft lighting creates gentle shadows that emphasize the three-dimensional form. Warm brown blurred background, professional photography, 1080x1080 square format, artisanal craft photography style, hyperrealistic detail.

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
