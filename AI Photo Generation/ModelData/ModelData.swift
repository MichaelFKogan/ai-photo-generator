//
//  ModelData.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

// ModelsData.swift
// Shared data for all AI models

import Foundation

enum ModelType {
    case video
    case image
}

struct Model: Identifiable {
    let id = UUID()           // or: let id: String = modelId
    let name: String
    let imageName: String
    let description: String
    let modelId: String
    let price: Double
    let type: ModelType

    // Common attributes
    let duration: String?
    let resolution: [String]?
    let latency: String?
    let aspectRatios: [String]?

    // Video-specific
    let textToVideo: Bool?
    let imageToVideo: Bool?
    let nativeAudio: Bool?
    let enhancePrompt: Bool?

    // Image-specific
    let textToImage: Bool?
    let imageToImage: Bool?
    
}



// Shared arrays for reuse across views
let videoModels = [
    Model(
            name: "Sora 2",
            imageName: "sora2",
            description: "OpenAI's next-generation video & audio generation model, delivering more accurate physics than previous generation model, with synchronized dialogue and high-fidelity visuals.",
            modelId: "openai:3@1",
            price: 0.80,
            type: .video,
            duration: "8s",
            resolution: ["720p", "1080p"],
            latency: "92s",
            aspectRatios: ["16:9", "9:16"],
            textToVideo: true,
            imageToVideo: true,
            nativeAudio: true,
            enhancePrompt: true,
            textToImage: nil,
            imageToImage: nil
        ),
    
//    Model(name: "Sora 2 Pro", imageName: "sora2pro", description: "Higher-quality variant of Sora 2 with extra resolution, refined control, and better consistency for demanding use cases.", modelId: "openai:3@2", price: 1.95),
    
    Model(
        name: "Google Veo 3",
        imageName: "veo3",
        description: "State-of-the-art video generation with native audio capabilities including dialogue, sound effects, and music. Excels in physics, realism, and prompt adherence.",
        modelId: "google:3@0",
        price: 3.20,
        type: .video,
        duration: "8s",
        resolution: ["720p", "1080p"],
        latency: "92s",
        aspectRatios: ["16:9", "9:16"],
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: true,
        enhancePrompt: true,
        textToImage: nil,
        imageToImage: nil
    ),
    
    //    Model(name: "Google Veo 3 Fast", imageName: "veo3fast", description: "Optimized version of Veo 3 offering faster generation speed with minimal quality loss. Supports native audio with dialogue, sound effects, and music. Excels in realistic motion, physics accuracy, and strong prompt following.", modelId: "google:3@1", price: 1.30),
    
    Model(
        name: "KlingAI",
        imageName: "klingai",
        description: "Next‑level creativity, turbocharged motion and cinematic visuals with precise prompt adherence. Supports both text‑to‑video and image‑to‑video workflows.",
        modelId: "klingai:6@1",
        price: 1.848,  // Matches KlingAI 2.1 Master in table
        type: .video,
        duration: "5s, 10s",
        resolution: ["1080p"],
        latency: "218s-570s",
        aspectRatios: ["16:9", "1:1", "9:16"],
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: false,
        enhancePrompt: false,
        textToImage: nil,
        imageToImage: nil
    ),
    
    //    Model(name: "KlingAI 2.5 Turbo Pro", imageName: "klingai25turbopro", description: "Next‑level creativity, turbocharged motion and cinematic visuals with precise prompt adherence. Supports both text‑to‑video and image‑to‑video workflows.", modelId: "klingai:6@1", price: 1.70),
    //    Model(name: "KlingAI 2.1 Master", imageName: "klingai21master", description: "Highest-end version with best-in-class coherence, photorealism, and multi-image reference capabilities for consistent character representation.", modelId: "klingai:5@3", price: 1.90),
    //    Model(name: "KlingAI 2.1 PRO (I2V)", imageName: "klingai21pro", description: "Professional variant with superior prompt adherence, advanced 3D spatiotemporal attention, and cinematic video quality.", modelId: "klingai:5@2", price: 1.65),
    //    Model(name: "KlingAI 2.1 STD (I2V)", imageName: "klingai21std", description: "Latest standard model with enhanced efficiency, improved quality, and faster generation times.", modelId: "klingai:5@1", price: 1.10),
    //    Model(name: "KlingAI 1.6 STD", imageName: "klingai16std", description: "Advanced text responsiveness with improved interpretation of motion, temporal actions, and camera movements.", modelId: "klingai:3@1", price: 0.75),
    //    Model(name: "KlingAI 1.6 PRO", imageName: "klingai16pro", description: "Top-tier model with smoother motion, natural expressions, and comprehensive upgrades in lighting dynamics and detailed rendering.", modelId: "klingai:3@2", price: 1.25),
    
    Model(
        name: "Wan",
        imageName: "wan",
        description: "Text-to-video and image-to-video with native audio generation, strong prompt adherence, smooth motion, and multilingual support in ~10-second clips.",
        modelId: "runware:201@1",
        price: 0.00,
        type: .video,
        duration: nil,         // No specific info from table
        resolution: nil,       // No specific info from table
        latency: nil,
        aspectRatios: nil,
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: true,
        enhancePrompt: nil,
        textToImage: nil,
        imageToImage: nil
    ),
//    Model(name: "Wan2.5-Preview", imageName: "wan25preview", description: "Text-to-video and image-to-video with native audio generation, strong prompt adherence, smooth motion, and multilingual support in ~10-second clips.", modelId: "runware:201@1", price: 1.45),
//    Model(name: "Wan2.2 A14B", imageName: "wan22a14b", description: "Text-to-video MoE model with two 14B experts for layout and detail; delivers cinematic 480p–720p video with strong visual quality and stable inference cost.", modelId: "runware:200@6", price: 1.20),


    Model(
        name: "Seedance 1.0",
        imageName: "seedance",
        description: "Advanced video model that creates smooth, high-quality 1080p clips up to 10 seconds long. Great for dynamic scenes, clean motion, and strong consistency across shots.",
        modelId: "bytedance:2@1",
        price: 1.3619,  // Matches Seedance 1.0 Pro in table
        type: .video,
        duration: "3s to 12s",
        resolution: ["480p", "1080p"],
        latency: "31s-95s",
        aspectRatios: ["1:1", "4:3", "16:9", "21:9", "3:4", "9:16", "9:21"],
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: false,
        enhancePrompt: false,
        textToImage: nil,
        imageToImage: nil
    ),
//    Model(name: "Seedance 1.0 Pro", imageName: "seedance10pro", description: "Advanced video model that creates smooth, high-quality 1080p clips up to 10 seconds long. Great for dynamic scenes, clean motion, and strong consistency across shots.", modelId: "bytedance:2@1", price: 1.60),
//    Model(name: "Seedance 1.0 Lite", imageName: "seedance10lite", description: "Lightweight and efficient model for fast video creation with 1080p output at 24fps. Features multi-shot storytelling and excellent prompt adherence.", modelId: "bytedance:1@1", price: 0.85),
    
    Model(
        name: "OmniHuman‑1",
        imageName: "omnihuman1",
        description: "Generates high-fidelity human videos from a single image and audio. Captures expressive motion, lip-sync, and emotional nuance",
        modelId: "bytedance:5@1",
        price: 0.00,
        type: .video,
        duration: nil,          // No specific info from table
        resolution: nil,
        latency: nil,
        aspectRatios: nil,
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: true,
        enhancePrompt: nil,
        textToImage: nil,
        imageToImage: nil
    ),
//    Model(name: "OmniHuman‑1", imageName: "omnihuman1", description: "Generates high-fidelity human videos from a single image and audio. Captures expressive motion, lip-sync, and emotional nuance", modelId: "bytedance:5@1", price: 1.40),
    
//    Model(name: "PixVerse v5", imageName: "pixversev5", description: "Major leap in text-to-video and image-to-video generation. Produces natural motion and cinematic visuals with high fidelity, excellent prompt adherence, and fast generation speed.", modelId: "pixverse:1@5", price: 0.95),

    
    Model(
        name: "MiniMax 02 Hailuo",
        imageName: "minimax02hailuo",
        description: "Most polished and dynamic model with vibrant, theatrical visuals and fluid motion. Ideal for viral content and commercial-style footage.",
        modelId: "minimax:3@1",
        price: 0.60,
        type: .video,
        duration: "5s, 10s",
        resolution: ["512p", "768p", "1080p"],
        latency: "41s-400s",
        aspectRatios: ["1:1", "4:3", "16:9"],
        textToVideo: true,
        imageToVideo: true,
        nativeAudio: false,
        enhancePrompt: true,
        textToImage: nil,
        imageToImage: nil
    ),
//    Model(name: "MiniMax 01 Director", imageName: "minimax01director", description: "Advanced cinematic framing and lighting model producing film-like scenes with professional-grade control and reduced movement randomness.", modelId: "minimax:2@1", price: 1.55),
//    
//    Model(name: "PixVerse v4", imageName: "pixversev4", description: "Improves generation quality with support for advanced camera movements and motion modes. Effects and camera movement are mutually exclusive.", modelId: "pixverse:1@2", price: 0.65),
//    Model(name: "PixVerse v4.5", imageName: "pixversev45", description: "Supports refined camera motion and cinematic movements with fast mode capabilities. Remains a solid choice for stylized generation tasks.", modelId: "pixverse:1@3", price: 0.70),
//    
//    Model(name: "Vidu Q1", imageName: "viduq1", description: "Experimental variant featuring built-in audio generation and smooth cinematic transitions from first to last frame.", modelId: "vidu:1@1", price: 0.55),
//    Model(name: "Vidu 2.0", imageName: "vidu20", description: "Faster, more affordable generation. Supports 4s and 8s 1080p clips with batch creation, strong consistency, and special effects templates.", modelId: "vidu:2@0", price: 0.45)
]

let imageModels = [
    Model(
        name: "Gemini Flash Image 2.5 (Nano Banana)",
        imageName: "geminiflashimage25",
        description: "Built for complex visual tasks, it handles multi-image generation with coherent character identity while drawing on strong world understanding to guide edits and completions.",
        modelId: "google:4@1",
        price: 0.40,
        type: .image,
        duration: "N/A",
        resolution: ["1024p"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),
    
    Model(
        name: "GPT Image 1",
        imageName: "gptimage1",
        description: "GPT Image 1 is OpenAI's latest image model (March 2025), built on GPT‑4o. It generates high‑quality, diverse visuals with advanced prompt following, text layout, and fast editing capabilities.",
        modelId: "openai:1@1",
        price: 0.00,
        type: .image,
        duration: "N/A",
        resolution: ["1024p"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),
    
    Model(
        name: "Seedream 4.0",
        imageName: "seedream40",
        description: "Next-gen multimodal AI model for ultra-fast high-res generation (2K–4K) with batch/coherent outputs, natural-language editing, sequential outputs, and bilingual Chinese–English support.",
        modelId: "bytedance:5@0",
        price: 0.03,
        type: .image,
        duration: "N/A",
        resolution: ["2K", "4K"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9", "9:16"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),
    
    Model(
        name: "FLUX.1 Kontext [dev]",
        imageName: "fluxkontextdev",
        description: "Open-weights editing model for fast, precise edits with strong character and scene consistency.",
        modelId: "runware:106@1",
        price: 0.01,
        type: .image,
        duration: "N/A",
        resolution: ["1024p"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),
    
    Model(
        name: "FLUX.1 Kontext [pro]",
        imageName: "fluxkontextpro",
        description: "Fast, iterative editing with local + full-scene changes, preserving style across multiple.",
        modelId: "bfl:3@1",
        price: 0.04,
        type: .image,
        duration: "N/A",
        resolution: ["1024p"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),
    
    Model(
        name: "FLUX.1 Kontext [max]",
        imageName: "fluxkontextmax",
        description: "Best quality and prompt accuracy with faster, sharper edits + premium typography support.",
        modelId: "bfl:4@1",
        price: 0.08,
        type: .image,
        duration: "N/A",
        resolution: ["1024p"],
        latency: "N/A",
        aspectRatios: ["1:1", "16:9"],
        textToVideo: nil,
        imageToVideo: nil,
        nativeAudio: nil,
        enhancePrompt: nil,
        textToImage: true,
        imageToImage: true
    ),

    
    
    
    
//    Model(name: "Qwen-Image-Edit-Plus", imageName: "qwenimageeditplus", description: "An enhanced version of Qwen-Image-Edit that supports multi-image editing, improved consistency in single-image tasks, and native ControlNet conditioning for fine-grained control", modelId: "runware:108@22", price: 0.78),
//    
//    Model(name: "Qwen-Image-Edit", imageName: "qwenimageedit", description: "Designed for intelligent image editing, it applies targeted changes while keeping the original composition intact. Reliable results across a wide range of visual styles and prompts.", modelId: "runware:108@20", price: 0.62),
//    
//    Model(name: "Qwen-Image", imageName: "qwenimage", description: "Open‑source 20B multimodal model excelling at complex text rendering and precise image editing.", modelId: "runware:108@1", price: 0.55),
//    
//    Model(name: "FLUX.1 Krea [dev]", imageName: "flux1kreadev", description: "FLUX.1 Krea [dev] is a photorealistic open-weight model co‑developed with Krea AI. It offers distinctive, realistic results without the usual AI feel, and serves as a strong base for custom generations.", modelId: "runware:107@1", price: 0.88),
//    
//    Model(name: "SeedEdit 3.0", imageName: "seededit30", description: "SeedEdit 3.0 is ByteDance's advanced image editing model for precise, high-resolution control. It preserves unedited regions and follows prompts closely. Supports 4K output and generates results in under 15 seconds.", modelId: "bytedance:4@1", price: 1.15),
//    Model(name: "Seedream 3.0", imageName: "seedream30", description: "Seedream 3.0 is a bilingual (Chinese‑English) text‑to‑image model delivering fast, photorealistic images up to 2048×2048 resolution with industry‑leading text rendering and layout accuracy", modelId: "bytedance:3@1", price: 1.35),
//    
//    Model(name: "Ideogram 3.0", imageName: "ideogram30", description: "Ideogram 3.0 pushes design-level generation to new heights, with sharper text rendering and better composition. It also adds greater stylistic control, perfect for graphic-driven content.", modelId: "ideogram:4@1", price: 1.48),
//    Model(name: "Ideogram 3.0 Remix", imageName: "ideogram30remix", description: "Enables reinterpretation of existing designs with fresh styles or palettes, while preserving structural intent. Useful for A/B design testing or creative variation.", modelId: "ideogram:4@2", price: 1.52),
//    Model(name: "Ideogram 3.0 Edit", imageName: "ideogram30edit", description: "An inpainting model that lets you surgically edit or replace parts of an image, great for polishing visuals or fixing text without starting from scratch.", modelId: "ideogram:4@3", price: 1.38),
//    Model(name: "Ideogram 3.0 Reframe", imageName: "ideogram30reframe", description: "Expands visuals beyond their original borders using style-consistent outpainting, perfect for adapting content to new formats or aspect ratios.", modelId: "ideogram:4@4", price: 1.42),
//    Model(name: "Ideogram 3.0 Replace Background", imageName: "ideogram30replacebg", description: "Swap out the background while keeping foreground elements intact. Useful for product mockups or design overlays.", modelId: "ideogram:4@5", price: 1.28),
//    
//    Model(name: "Imagen 4 Preview", imageName: "imagen4preview", description: "Preview version of Google's latest image generation model, offering 2K resolution, superior detail rendering, and improved text generation capabilities across various styles.", modelId: "google:2@1", price: 1.58),
//    Model(name: "Imagen 4 Ultra", imageName: "imagen4ultra", description: "Google's latest model offering photorealistic images, sharper clarity, improved typography, and near real-time generation.", modelId: "google:2@2", price: 1.88),
//    Model(name: "Imagen 4 Fast", imageName: "imagen4fast", description: "Google's latest model offering photorealistic images, sharper clarity, improved typography, and near real-time generation.", modelId: "google:2@3", price: 0.98),
//    
//    
//    Model(name: "FLUX.1.1 [pro]", imageName: "flux11pro", description: "Enhanced version with improved image quality, prompt adherence, and output diversity, delivering faster and more accurate results.", modelId: "bfl:2@1", price: 1.22),
//    Model(name: "FLUX.1.1 [pro] Ultra", imageName: "flux11proultra", description: "High-resolution model capable of generating images up to 4 megapixels, offering ultra and raw modes for detailed and realistic outputs.", modelId: "bfl:2@2", price: 1.82),
//    
//    Model(name: "HiDream-i1 Fast", imageName: "hidreami1fast", description: "Built for speed. Great for fast drafts, real-time ideas, and bulk jobs. Surprisingly strong prompt adherence and structure for its size.", modelId: "runware:97@3", price: 0.32),
//    Model(name: "HiDream-i1 Dev", imageName: "hidreami1dev", description: "Balances quality and speed. Supports LoRAs and produces clean, detailed images. Ideal for testing ideas and refining styles.", modelId: "runware:97@2", price: 0.48),
//    Model(name: "HiDream-i1 Full", imageName: "hidreami1full", description: "The highest quality HiDream model. Sharp detail, accurate prompts, and full LoRA compatibility. Fully uncensored for creative freedom.", modelId: "runware:97@1", price: 0.82),
//    
//    Model(name: "FLUX.1 [schnell]", imageName: "flux1schnell", description: "Ultra-fast text-to-image generation with 4-step distillation, ideal for local deployment and quick results.", modelId: "runware:100@1", price: 0.25),
//    
//    Model(name: "Juggernaut Pro Flux by RunDiffusion", imageName: "juggernautproflux", description: "Combines Juggernaut Base with RunDiffusion Photo and features enhancements like reduced background blur.", modelId: "rundiffusion:130@100", price: 0.92),
//    Model(name: "Juggernaut Lightning Flux by RunDiffusion", imageName: "juggernautlightningflux", description: "Blazing-fast, high-quality images rendered at five times the speed of Flux. Perfect for mood boards and mass ideation, this model scales to both solo", modelId: "rundiffusion:110@101", price: 0.38)
]
