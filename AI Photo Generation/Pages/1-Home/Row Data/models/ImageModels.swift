//
//  texttoimage.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let imageModelsRow = [

    // ---------------------------------------------------------
    // MARK: - Google Nano Banana (Gemini Flash 2.5)
    // ---------------------------------------------------------
    InfoPacket(
        title: "Google Nano Banana",
        cost: 0.05,

        imageName: "geminiflashimage25",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Gemini Flash 2.5 / Nano Banana",
        modelDescription:
            "A fast, lightweight model built for clean enhancements, realistic textures, and quick image edits. Ideal for portraits, product shots, and everyday transformations.",
        modelImageName: "geminiflashimage25",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - GPT Image 1
    // ---------------------------------------------------------
    InfoPacket(
        title: "GPT Image 1",
        cost: 0.15,

        imageName: "gptimage1",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "GPT Image 1",
        modelDescription:
            "A creative-focused model that excels at stylized visuals, artistic reimagining, and expressive compositions. Great for fantasy, concept art, and cinematic stills.",
        modelImageName: "gptimage1",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - Seedream 4.0
    // ---------------------------------------------------------
    InfoPacket(
        title: "Seedream 4.0",
        cost: 0.04,

        imageName: "seedream40",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Seedream 4.0",
        modelDescription:
            "Known for soft lighting, vivid color gradients, and dreamy realism. Ideal for lifestyle images, outdoor scenes, illustrations, and aesthetic-focused designs.",
        modelImageName: "seedream40",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - FLUX.1 Kontext [dev]
    // ---------------------------------------------------------
    InfoPacket(
        title: "FLUX.1 Kontext [dev]",
        cost: 0.04,

        imageName: "fluxkontextdev",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [dev]",
        modelDescription:
            "An experimental model focused on structure, clarity, and accurate scene composition. Best for previews, drafts, and rapid creative exploration.",
        modelImageName: "fluxkontextdev",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - FLUX.1 Kontext [pro]
    // ---------------------------------------------------------
    InfoPacket(
        title: "FLUX.1 Kontext [pro]",
        cost: 0.08,

        imageName: "fluxkontextpro",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [pro]",
        modelDescription:
            "A high-quality image generator with refined detail, clean edges, and strong lighting control. Excellent for portraits, branding work, and polished professional visuals.",
        modelImageName: "fluxkontextpro",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - FLUX.1 Kontext [max]
    // ---------------------------------------------------------
    InfoPacket(
        title: "FLUX.1 Kontext [max]",
        cost: 0.12,

        imageName: "fluxkontextmax",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Image Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "FLUX.1 Kontext [max]",
        modelDescription:
            "The most advanced version of the FLUX line—built for large scenes, deep texture detail, complex lighting, and ultra-realistic rendering. Perfect for high-impact creative work.",
        modelImageName: "fluxkontextmax",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),
]
