//
//  AllPhotoFiltersRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/31/25.
//

let allPhotoFilters = [

    InfoPacket(
        imageName: "anime1",
        imageNameOriginal: "anime",
        
        title: "Anime",
        cost: 0.04,
        description: "",
        prompt: "",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/wavespeed-ai/ghibli",
        modelName: "",
        modelDescription: "",
        modelImageName: "",
        exampleImages: ["anime2", "anime3", "anime4", "anime5", "anime6", "anime7"],
        
        aspectRatio: "",
        outputFormat: "jpeg",
        enableSyncMode: true,
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "minecraft1",
        imageNameOriginal: "minecraft",
        title: "Blocky Aesthetic",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/my-world",
        exampleImages: ["minecraft2", "minecraft3", "minecraft4", "minecraft5", "minecraft6", "minecraft7"]
    ),
    InfoPacket(
        imageName: "micro-landscape-mini-world1",
        imageNameOriginal: "micro-landscape-mini-world",
        title: "Micro Landscape",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/micro-landscape-mini-world",
        exampleImages: ["micro-landscape-mini-world2", "micro-landscape-mini-world3", "micro-landscape-mini-world4", "micro-landscape-mini-world5", "micro-landscape-mini-world6", "micro-landscape-mini-world7"]
    ),
    InfoPacket(
        imageName: "plasticbubblefigure1",
        imageNameOriginal: "plasticbubblefigure",
        title: "Plastic Bubble Figure",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/plastic-bubble-figure",
        exampleImages: ["plasticbubblefigure6", "plasticbubblefigure3", "plasticbubblefigure4", "plasticbubblefigure5", "plasticbubblefigure2", "plasticbubblefigure7"]
    ),
    InfoPacket(
        imageName: "trending1",
        imageNameOriginal: "trending",
        
        title: "Designer Toy Figure",
        cost: 0.04,
        description: "",
        prompt: "create a 1/7 scale commercialized figure of thecharacter in the illustration, in a realistic styie and environment.Place the figure on a computer desk, using a circular transparent acrylic base without any text.On the computer screen, display the ZBrush modeling process of the figure.Next to the computer screen, place a BANDAI-style toy packaging box printedwith the original artwork.",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "nano-banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "felt3dpolaroid1",
        imageNameOriginal: "felt3dpolaroid",
        title: "Felt 3D Polaroid",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/felt-3d-polaroid",
        exampleImages: ["felt3dpolaroid2", "felt3dpolaroid3", "felt3dpolaroid4", "felt3dpolaroid5", "felt3dpolaroid6", "felt3dpolaroid7"]
    ),
    InfoPacket(
        imageName: "glassball1",
        imageNameOriginal: "glassball",
        title: "Snow Globe",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/glass-ball",
        exampleImages: ["glassball2", "glassball3", "glassball4", "glassball5", "glassball6", "glassball7"]
    ),
    InfoPacket(
        imageName: "futuristic1",
        imageNameOriginal: "futuristic",
        title: "Futuristic",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/futuristic-american-comics",
        exampleImages: ["futuristic2", "futuristic3", "futuristic4", "futuristic5", "futuristic6", "futuristic7"]
    ),
    InfoPacket(
        imageName: "cyberpunk1",
        imageNameOriginal: "cyberpunk",
        title: "Cyberpunk",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/cyberpunk",
        exampleImages: ["cyberpunk2", "cyberpunk3", "cyberpunk4", "cyberpunk5", "cyberpunk6", "cyberpunk7"]
    ),
    InfoPacket(
        imageName: "lowkeylighting1",
        imageNameOriginal: "lowkeylighting",
        title: "Low-Key Lighting",
        cost: 0.04,
        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/advanced-photography",
        exampleImages: ["lowkeylighting2", "lowkeylighting3", "lowkeylighting4", "lowkeylighting5", "lowkeylighting6", "lowkeylighting7"]
    ),
    InfoPacket(
        imageName: "black",
        imageNameOriginal: "black",
        
        title: "Cinematic Fusion",
        cost: 0.04,
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: "A [subject] blending cultural influences, adorned in symbolic armor with engraved patterns, standing in a dramatic setting beneath a moody sky. Cinematic composition, chiaroscuro lighting, sweeping camera angle, authentic film stock color palette, grainy 35mm texture, hyper-detailed, epic atmosphere, captured in a vintage cinematic style.",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "nano-banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "black",
        imageNameOriginal: "black",
        
        title: "Watercolor",
        cost: 0.04,
        description: "",
        prompt: "Convert to watercolor painting",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "nano-banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        imageName: "black",
        imageNameOriginal: "black",
        
        title: "The Sims",
        cost: 0.04,
        description: "",
        prompt: "Recreate the subject from the provided image as a Sim character from The Sims. The Sim should have a glowing green plumbob above their head and be placed inside a beautifully decorated, modern-style home. The scene must be rendered in a classic top-down, slightly angled isometric view, characteristic of The Sims gameplay, clearly showing the room's layout. All objects, architecture, and lighting must be consistent with the vibrant, stylized aesthetic of The Sims. The décor should feature detailed retro-futuristic elements, with intricate patterns on fabrics, rich wood textures, and unique artwork. Ensure the background colour behind the house matches the scene Crucially, the Sim's face must retain a strong likeness to the subject in the photo, capturing their key facial features and expression, while being artistically rendered to fit seamlessly into The Sims art style.",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "nano-banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    
    
    
    
    
    
//    "Create a highly photorealistic image captured with a professional full-frame DSLR or mirrorless camera, using a prime lens with a wide aperture (e.g., 50mm f/1.4), in natural lighting conditions. The image must contain authentic, real-world imperfections such as subtle lens distortions, natural grain/noise, bokeh depth of field effects, realistic lighting shadows and highlights, skin pore textures, environmental reflections, micro-hair strands, and accurate ambient occlusion. The subject should have natural skin tones with sub-surface scattering, slightly asymmetrical features as seen in real human faces, and organic motion or expression.
//
//    Background should include photorealistic details such as dust particles in the air, realistic sky tone gradients or environmental lighting (e.g., golden hour sunlight, shade gradients), and background blur that follows true optical depth simulation. Colors must be balanced realistically, respecting white balance and real-world color grading, such as mild chromatic aberration near image edges. Ensure accurate anatomy, fabric folds, reflections, light bounce, and focus transitions.
//
//    The camera perspective should simulate real lens behavior — include correct parallax, perspective compression or expansion (depending on focal length), and real-world framing such as candid compositions, slightly off-center focus, or over-the-shoulder framing. Include natural imperfections like flyaway hairs, slight skin blemishes, uneven fabric, small wrinkles, and real light scattering effects in transparent or reflective materials. Avoid excessive smoothness or symmetry. This image should be indistinguishable from a photograph taken by a skilled photographer — even professional analysts and AI detection systems should be unable to identify it as AI-generated. The image must comply with all real-world physics and visual logic."
    
    
    
    
//    LinkedIn Headshot
//    Prompt: Transform the existing photo into a high-quality, professional LinkedIn headshot. Be sure to highlight the subject’s natural features (eyes, hair, skin tone, etc) with complimentary true-to-life colors and smooth, even lighting. Dress the subject in modern attire that's polished but approachable (avoid suits, ties, and collared shirts). Use a clean, neutral, quiet city scape background with soft depth of field to keep the focus on the subject while adding a subtle, contemporary look. Frame the image tightly on the head and upper shoulders. Ensure the final image is sharp, well-lit, and conveys confidence, professionalism, and approachability, while retaining the subject's natural features and look.
    
    
    
    
//    1. Gemini AI Prompt for Couple Photo Retro
//    Create a 1980s retro-style couple portrait. The couple should be smiling, sitting on a vintage brown leather sofa, with warm golden lighting. Outfits: man in a blue denim shirt and black pants, woman in a white saree and necessary adornments. Add soft grainy film texture and a faded photo album look, as if taken in a retro photo studio."
//
//    2. Video Game Character Transformation
//    "Turn this person into a 16-bit video game character inside a classic 2D platformer level. Outfit: colorful pixelated armor with glowing accents. Background: floating pixel platforms with retro clouds and mountains. Style: pixel art, bright arcade colors, cartoonish proportions, crisp sharp outlines."
    
//    8. Pencil Drawing Style Portrait
//    "Convert this portrait into a hand-drawn pencil sketch. Style: hyper-detailed graphite pencil strokes, soft shading, textured paper background, cross-hatching details around eyes and hair. Lighting: soft grayscale shading for depth."
//
//    9. Epic Superhero Story Prompt
//    "Create a 9-frame comic book sequence featuring this couple as superheroes. Frame 1: they discover their powers. Frame 2-4: training montage. Frame 5: battle with villain in a futuristic city. Frame 6: dramatic mid-air fight. Frame 7: saving civilians. Frame 8: victory pose. Frame 9: close-up of their hands holding. Style: Marvel comic book, bold colors, inked outlines."
    
    
    
]

