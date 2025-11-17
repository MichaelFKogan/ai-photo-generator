//
//  texttovideo.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let videoModelsRow = [

    // ---------------------------------------------------------
    // MARK: - Sora 2
    // ---------------------------------------------------------
    InfoPacket(
        title: "Sora 2",
        cost: 0.80,

        imageName: "sora2",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Video Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Sora 2",
        modelDescription:
            "Sora 2 is designed for cinematic-quality video generation with extremely stable motion, improved physics accuracy, expressive character animation, and rich scene detail. Perfect for storytelling, ads, and high-impact creative content.",
        modelImageName: "sora2",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - Google Veo 3
    // ---------------------------------------------------------
    InfoPacket(
        title: "Google Veo 3",
        cost: 0.80,

        imageName: "veo3",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Video Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Google Veo 3",
        modelDescription:
            "Veo 3 focuses on clarity, smooth motion, and natural lighting. It excels at dynamic environments, realistic textures, and clean camera transitions—ideal for lifestyle clips, outdoor scenes, product demos, and fast-paced creative content.",
        modelImageName: "veo3",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - Kling AI
    // ---------------------------------------------------------
    InfoPacket(
        title: "Kling AI",
        cost: 0.80,

        imageName: "klingai",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Video Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Kling AI",
        modelDescription:
            "Kling AI specializes in hyper-realistic motion and high-speed action scenes. With sharp detail and stable, precise frame-to-frame movement, it’s a strong choice for sports, sci-fi shots, fast motion, and large sweeping environments.",
        modelImageName: "klingai",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),

    // ---------------------------------------------------------
    // MARK: - Wan 2.5
    // ---------------------------------------------------------
    InfoPacket(
        title: "Wan 2.5",
        cost: 1.00,

        imageName: "wan",
        imageNameOriginal: "yourphoto",

        description: "",
        prompt: "",
        type: "AI Video Model",

        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Wan 2.5",
        modelDescription:
            "Wan 2.5 delivers dramatic cinematic visuals, advanced character performance, atmospheric effects, and stylized world-building. It shines in fantasy, anime, surreal scenes, and richly creative storytelling.",
        modelImageName: "wan",
        exampleImages: [],

        aspectRatio: nil,
        outputFormat: "jpeg",
        enableSyncMode: false,
        enableBase64Output: false
    ),
]
