//
//  VideoGamesRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/13/25.
//

let videogamesItems = [
    InfoPacket(
        title: "Blocky Aesthetic",
        cost: 0.04,
        
        imageName: "minecraft1",
        imageNameOriginal: "minecraft",

        description: "My-World is an image effect model that converts input images into vibrant Minecraft-style pixelated scenes, recreating the blocky, iconic aesthetic of the popular game.",
        prompt: "",
        modelName: "",
        modelDescription: "",
        modelImageName: "",
        exampleImages: ["minecraft2", "minecraft3", "minecraft4", "minecraft5", "minecraft6", "minecraft7"]
    ),
    InfoPacket(
        title: "16-Bit Game",
        cost: 0.05,
        
        imageName: "yourphoto",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "Turn this photo into a 16-bit video game style. Style: pixel art, bright arcade colors, cartoonish proportions, crisp sharp outlines.",
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
        title: "16-Bit Game",
        cost: 0.05,
        
        imageName: "16bit",
        imageNameOriginal: "yourphoto",
        
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
        title: "Superhero Comic",
        cost: 0.05,
        
        imageName: "comicsequence",
        imageNameOriginal: "yourphoto",
        
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
    InfoPacket(
        title: "The Sims",
        cost: 0.05,
        
        imageName: "thesims",
        imageNameOriginal: "yourphoto",
        
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
        title: "Cinematic Fusion",
        cost: 0.05,
        
        imageName: "cinematicfusion",
        imageNameOriginal: "yourphoto",
        
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
        title: "Cyberpunk",
        cost: 0.04,
        
        imageName: "cyberpunk1",
        imageNameOriginal: "cyberpunk",

        description: "Cyberpunk is an image effect model that transforms photos into futuristic, neon-lit scenes inspired by cyberpunk aesthetics, featuring vibrant colors, glowing lights, and high-tech urban vibes.",
        prompt: "",
        modelName: "",
        modelDescription: "",
        modelImageName: "",
        exampleImages: ["cyberpunk2", "cyberpunk3", "cyberpunk4", "cyberpunk5", "cyberpunk6", "cyberpunk7"]
    ),
]
