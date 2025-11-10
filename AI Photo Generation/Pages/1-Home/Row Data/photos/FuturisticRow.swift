//
//  FuturisticRow.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/14/25.
//

let futuristicItems = [
    InfoPacket(
        title: "Futuristic",
        cost: 0.04,
        
        imageName: "futuristic1",
        imageNameOriginal: "futuristic",

        description: "Futuristic-American-Comics is an image effect model that transforms images into vibrant, high-tech comic-style artwork blending classic American comic aesthetics with futuristic sci-fi elements.",
        prompt: "",
        modelName: "",
        modelDescription: "",
        modelImageName: "",
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
]
