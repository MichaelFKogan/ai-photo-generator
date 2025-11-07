//
//  Photobooth.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/6/25.
//

let photobooth = [
    InfoPacket(
        title: "90s Polaroid",
        cost: 0.05,
        
        imageName: "90spolaroid1",
        imageNameOriginal: "90spolaroid",
        
        description: "",
        prompt: """
        
        Flash Photography with Grain
        
        Render the image as if it were an authentic 90s Polaroid snapshot taken indoors. Apply the look of a harsh on-camera flash, resulting in bright highlights, deep, dark shadows, and a slight red-eye effect. The photograph must exhibit noticeable film grain and the characteristic blue-green tint often found in instant film. Enclose the photo in a clean, white Polaroid 600-style frame with a slight vignette effect within the image area.
        
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
        title: "Photobooth",
        cost: 0.05,
        
        imageName: "photobooth",
        imageNameOriginal: "90spolaroid",
        
        description: "",
        prompt: "Transform the given image into a vertical strip of four distinct photobooth-style snapshots. Each individual frame should be a slightly different, spontaneous take on the original image, as if taken seconds apart. Introduce subtle variations in facial expression (if applicable), head tilt, or minor shifts in pose between the four frames. The lighting for each frame should be a slightly harsh, direct flash, creating subtle highlights and shadows. The entire strip should be presented against a neutral, plain background, with a classic, thin white border around each individual photo and a consistent, slightly aged, warm color cast across all four. Each photo background should mimic a photobooth.",
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
        title: "Pencil Sketch Portrait",
        cost: 0.05,
        
        imageName: "yourphoto",
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

