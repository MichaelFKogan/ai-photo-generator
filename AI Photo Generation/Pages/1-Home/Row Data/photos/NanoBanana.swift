//
//  NanoBanana.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//


let nanoBanana = [
    InfoPacket(
        imageName: "cinematicfusion",
        imageNameOriginal: "yourphoto",
        
        title: "Cinematic Fusion",
        cost: 0.04,
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: "A [subject] blending cultural influences, adorned in symbolic armor with engraved patterns, standing in a dramatic setting beneath a moody sky. Cinematic composition, chiaroscuro lighting, sweeping camera angle, authentic film stock color palette, grainy 35mm texture, hyper-detailed, epic atmosphere, captured in a vintage cinematic style.",
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
        imageName: "3dcaricature",
        imageNameOriginal: "yourphoto",
        
        title: "3D Caricature",
        cost: 0.05,
        description: "Transform your photo into a cinematic masterpiece with dramatic lighting and epic atmosphere.",
        prompt: """
            
            Full-body 3D caricature of [Character Name] in Pixar/DreamWorks style, featuring expressive large eyes, slightly oversized head, and subtly exaggerated facial features. 
            
            Realistic skin with soft subsurface scattering, detailed hair, and a gentle warm smile. Smooth polished surfaces with subtle fabric texture on clothing. 
            
            Dynamic pose showing personality, with full body visible and balanced proportions. 
            
            Soft ambient lighting, warm reddish-orange or bluish gradient background. 
            
            Cinematic quality, high detail, vibrant yet natural colors, stylized charm with balanced realism.
            
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "90s Polaroid",
        cost: 0.05,
        description: "",
        prompt: """

        Option 1: Classic, Warm Look
        
        A digital image converted into a 90s-style instant film photograph (Polaroid). The image should have a strong, warm, slightly yellowed color cast, mimicking aged film. Use soft, diffused, low-key natural lighting coming from the side to create gentle shadows. The frame should be a classic white Polaroid border, slightly thicker at the bottom, with a faint, subtle crease or minor imperfection near the edge.
        
        Option 2: Flash Photography with Grain
        
        Render the image as if it were an authentic 90s Polaroid snapshot taken indoors. Apply the look of a harsh on-camera flash, resulting in bright highlights, deep, dark shadows, and a slight red-eye effect. The photograph must exhibit noticeable film grain and the characteristic blue-green tint often found in instant film. Enclose the photo in a clean, white Polaroid 600-style frame with a slight vignette effect within the image area.
        
        Option 3: Outdoor, Sunny Retro
        
        A photograph with the aesthetic of a well-preserved 90s Polaroid. The lighting should be bright, midday sunlight, slightly overexposed to wash out the colors just a bit. Give the image a noticeable magenta-red color shift in the shadows. The frame should be a stark, white Polaroid SX-70 frame, perfectly clean and crisp, suggesting it was recently taken and developed.
        
        """,
        
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "Photobooth",
        cost: 0.04,
        description: "",
        prompt: "Transform the given image into a vertical strip of four distinct photobooth-style snapshots. Each individual frame should be a slightly different, spontaneous take on the original image, as if taken seconds apart. Introduce subtle variations in facial expression (if applicable), head tilt, or minor shifts in pose between the four frames. The lighting for each frame should be a slightly harsh, direct flash, creating subtle highlights and shadows. The entire strip should be presented against a neutral, plain background, with a classic, thin white border around each individual photo and a consistent, slightly aged, warm color cast across all four.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "Watercolor",
        cost: 0.04,
        description: "",
        prompt: "Convert this image into a vivid and expressive watercolor artwork. Use bold, saturated colors with dynamic brushwork and strong contrasts. Show distinct wet-on-wet blending techniques and intentional drips or splatters, giving it a more energetic and modern watercolor feel. The details should be impressionistic rather than hyper-realistic, capturing the essence with vibrant hues.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "The Sims",
        cost: 0.04,
        description: "",
        prompt: "Recreate the subject from the provided image as a Sim character from The Sims. The Sim should have a glowing green plumbob above their head and be placed inside a beautifully decorated, modern-style home. The scene must be rendered in a classic top-down, slightly angled isometric view, characteristic of The Sims gameplay, clearly showing the room's layout. All objects, architecture, and lighting must be consistent with the vibrant, stylized aesthetic of The Sims. The décor should feature detailed retro-futuristic elements, with intricate patterns on fabrics, rich wood textures, and unique artwork. Ensure the background colour behind the house matches the scene Crucially, the Sim's face must retain a strong likeness to the subject in the photo, capturing their key facial features and expression, while being artistically rendered to fit seamlessly into The Sims art style.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "Photorealistic DSLR Transformation",
        cost: 0.04,
        description: "",
        prompt: """
        Create a highly photorealistic image captured with a professional full-frame DSLR or mirrorless camera, using a prime lens with a wide aperture (e.g., 50mm f/1.4), in natural lighting conditions. The image must contain authentic, real-world imperfections such as subtle lens distortions, natural grain/noise, bokeh depth of field effects, realistic lighting shadows and highlights, skin pore textures, environmental reflections, micro-hair strands, and accurate ambient occlusion. The subject should have natural skin tones with sub-surface scattering, slightly asymmetrical features as seen in real human faces, and organic motion or expression.
        
        Background should include photorealistic details such as dust particles in the air, realistic sky tone gradients or environmental lighting (e.g., golden hour sunlight, shade gradients), and background blur that follows true optical depth simulation. Colors must be balanced realistically, respecting white balance and real-world color grading, such as mild chromatic aberration near image edges. Ensure accurate anatomy, fabric folds, reflections, light bounce, and focus transitions.

        The camera perspective should simulate real lens behavior — include correct parallax, perspective compression or expansion (depending on focal length), and real-world framing such as candid compositions, slightly off-center focus, or over-the-shoulder framing. Include natural imperfections like flyaway hairs, slight skin blemishes, uneven fabric, small wrinkles, and real light scattering effects in transparent or reflective materials. Avoid excessive smoothness or symmetry. This image should be indistinguishable from a photograph taken by a skilled photographer — even professional analysts and AI detection systems should be unable to identify it as AI-generated. The image must comply with all real-world physics and visual logic.
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "LinkedIn Headshot",
        cost: 0.04,
        description: "",
        prompt: "Transform the existing photo into a high-quality, professional LinkedIn headshot. Be sure to highlight the subject’s natural features (eyes, hair, skin tone, etc) with complimentary true-to-life colors and smooth, even lighting. Dress the subject in modern attire that's polished but approachable (avoid suits, ties, and collared shirts). Use a clean, neutral, quiet city scape background with soft depth of field to keep the focus on the subject while adding a subtle, contemporary look. Frame the image tightly on the head and upper shoulders. Ensure the final image is sharp, well-lit, and conveys confidence, professionalism, and approachability, while retaining the subject's natural features and look.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "80s Couple Retro Portrait (Gemini)",
        cost: 0.04,
        description: "",
        prompt: "Create a 1980s retro-style couple portrait. The couple should be smiling, sitting on a vintage brown leather sofa, with warm golden lighting. Outfits: man in a blue denim shirt and black pants, woman in a white saree and necessary adornments. Add soft grainy film texture and a faded photo album look, as if taken in a retro photo studio.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "16-Bit Game Character Transformation",
        cost: 0.04,
        description: "",
        prompt: "Turn this person into a 16-bit video game character inside a classic 2D platformer level. Outfit: colorful pixelated armor with glowing accents. Background: floating pixel platforms with retro clouds and mountains. Style: pixel art, bright arcade colors, cartoonish proportions, crisp sharp outlines.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "Pencil Sketch Portrait",
        cost: 0.04,
        description: "",
        prompt: "Convert this portrait into a hand-drawn pencil sketch. Style: hyper-detailed graphite pencil strokes, soft shading, textured paper background, cross-hatching details around eyes and hair. Lighting: soft grayscale shading for depth.",
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
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        title: "Superhero Comic Story Sequence",
        cost: 0.04,
        description: "",
        prompt: "Create a 9-frame comic book sequence featuring this couple as superheroes. Frame 1: they discover their powers. Frame 2-4: training montage. Frame 5: battle with villain in a futuristic city. Frame 6: dramatic mid-air fight. Frame 7: saving civilians. Frame 8: victory pose. Frame 9: close-up of their hands holding. Style: Marvel comic book, bold colors, inked outlines.",
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

