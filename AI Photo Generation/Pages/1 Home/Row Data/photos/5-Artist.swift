//
//  4-artist.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/7/25.
//

let artist = [
    
    InfoPacket(
        title: "Watercolor",
        cost: 0.05,
        
        imageName: "watercolor",
        imageNameOriginal: "90spolaroid",
        
        description: "",
        prompt: "Convert this image into a watercolor painting on a white canvas. Show the canvas stand and paintbrushes in the image.",
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
        title: "Van Gogh",
        cost: 0.05,
        
        imageName: "vangogh",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "Convert this image into a Van Gogh style painting.",
        type: "Photo Filter",
        
        endpoint: "https://api.wavespeed.ai/api/v3/bytedance/seedream-v4/edit",
        modelName: "Seedream v4",
        modelDescription: "",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: nil,  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Colored Pencil Drawing",
        cost: 0.05,
        
        imageName: "coloredpencildrawing",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "Convert this image into a realistic, detailed colored pencil drawing rendered directly onto a page of an open sketchbook or journal. The drawing should be centered on the page, with the paper having a light tan or sepia-toned texture. Around the drawing, subtly arranged on the notebook or next to it, include a few colored pencils whose lead colors visually match prominent hues within the generated drawing. Apply soft, visible pencil strokes and hatching for the drawing's texture. The rendering should be hyper-detailed and refined, characteristic of pastel or colored pencil fine art portraiture. Use a soft, ethereal lighting that highlights both the drawing and the surrounding elements. Retain the subject's pose, expression, and features.",
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
        title: "Pencil Sketch",
        cost: 0.05,
        
        imageName: "pencilsketch",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: "Convert the portrait into a hand-drawn pencil sketch shown on a page of a ruled notebook. Style: hyper-detailed graphite pencil strokes, soft shading, with cross-hatching details around the eyes and hair. Include a pencil and an eraser resting to the side of the drawing. Lighting: soft grayscale shading for depth, and showing the texture of the ruled paper.",
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

