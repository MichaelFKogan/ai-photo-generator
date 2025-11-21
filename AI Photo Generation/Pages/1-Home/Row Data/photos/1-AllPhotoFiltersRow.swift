//
//  AllPhotoFiltersRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/31/25.
//

let allPhotoFilters = [

    InfoPacket(
        title: "Anime",
        cost: 0.05,
        
        imageName: "anime1",
        imageNameOriginal: "anime",
        
        description: "",
        prompt: "",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/wavespeed-ai/ghibli",
        modelName: "",
        modelDescription: "",
        modelImageName: "",
        exampleImages: ["anime2", "anime3", "anime4", "anime5", "anime6", "anime7"],
        moreStyles: [
//            allPhotoFilters,
            Caricature,
            photobooth,
            halloween,
            artist,
            luxury,
            videogamesItems,
            chibi,
            cute,
            nanoBananaTwo,
            outdoorsPhotography,
            streetPhotography,
            fashion,
            mensfashion,
            linkedInHeadshots,
//            relationshipItems
        ],
        
        aspectRatio: "",
        outputFormat: "jpeg",
        enableSyncMode: true,
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Blocky Aesthetic",
        cost: 0.05,
        
        imageName: "minecraft1",
        imageNameOriginal: "minecraft",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/my-world",
        exampleImages: ["minecraft2", "minecraft3", "minecraft4", "minecraft5", "minecraft6", "minecraft7"]
    ),
    InfoPacket(
        title: "Micro Landscape",
        cost: 0.05,
        
        imageName: "micro-landscape-mini-world1",
        imageNameOriginal: "micro-landscape-mini-world",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/micro-landscape-mini-world",
        exampleImages: ["micro-landscape-mini-world2", "micro-landscape-mini-world3", "micro-landscape-mini-world4", "micro-landscape-mini-world5", "micro-landscape-mini-world6", "micro-landscape-mini-world7"]
    ),
    InfoPacket(
        title: "Plastic Bubble Figure",
        cost: 0.05,
        
        imageName: "plasticbubblefigure1",
        imageNameOriginal: "plasticbubblefigure",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/plastic-bubble-figure",
        exampleImages: ["plasticbubblefigure6", "plasticbubblefigure3", "plasticbubblefigure4", "plasticbubblefigure5", "plasticbubblefigure2", "plasticbubblefigure7"]
    ),
    InfoPacket(
        title: "Designer Toy Figure",
        cost: 0.05,
        
        imageName: "trending1",
        imageNameOriginal: "trending",
        
        description: "",
        prompt: "Turn this photo into a character figure. Behind it, place a box with the character's image printed on it,and a computer showing the Blender modeling process on its screen. In frontof the box, add a round plastic base with the character figure standing on it. Set the scene indoors if possible.",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Gemini Flash 2.5 (Nano Banana)",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Felt 3D Polaroid",
        cost: 0.05,
        
        imageName: "felt3dpolaroid1",
        imageNameOriginal: "felt3dpolaroid",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/felt-3d-polaroid",
        exampleImages: ["felt3dpolaroid2", "felt3dpolaroid3", "felt3dpolaroid4", "felt3dpolaroid5", "felt3dpolaroid6", "felt3dpolaroid7"]
    ),
    InfoPacket(
        title: "Snow Globe",
        cost: 0.05,
        
        imageName: "glassball1",
        imageNameOriginal: "glassball",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/glass-ball",
        exampleImages: ["glassball2", "glassball3", "glassball4", "glassball5", "glassball6", "glassball7"]
    ),
    InfoPacket(
        title: "Futuristic",
        cost: 0.05,
        
        imageName: "futuristic1",
        imageNameOriginal: "futuristic",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/futuristic-american-comics",
        exampleImages: ["futuristic2", "futuristic3", "futuristic4", "futuristic5", "futuristic6", "futuristic7"]
    ),
    InfoPacket(
        title: "Cyberpunk",
        cost: 0.05,
        
        imageName: "cyberpunk1",
        imageNameOriginal: "cyberpunk",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/cyberpunk",
        exampleImages: ["cyberpunk2", "cyberpunk3", "cyberpunk4", "cyberpunk5", "cyberpunk6", "cyberpunk7"]
    ),
    InfoPacket(
        title: "Low-Key Lighting",
        cost: 0.05,
        
        imageName: "lowkeylighting1",
        imageNameOriginal: "lowkeylighting",

        type: "Photo Filter",
        endpoint: "https://api.wavespeed.ai/api/v3/image-effects/advanced-photography",
        exampleImages: ["lowkeylighting2", "lowkeylighting3", "lowkeylighting4", "lowkeylighting5", "lowkeylighting6", "lowkeylighting7"]
    ),

]

