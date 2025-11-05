//
//  NanoBananaTwo.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/4/25.
//

let outdoorsPhotography = [
    InfoPacket(
        imageName: "goldenhourelegance",
        imageNameOriginal: "yourphoto",
        
        title: "Golden Hour Elegance",
        cost: 0.05,
        description: "",
        prompt: """
        
        Create a cinematic portrait using the facial features of the reference image. The woman stands in a wide open grassy field at golden hour, warm sunlight casting soft directional light across her face and hair. 
        
        Background: tree-lined horizon, long shadows, serene countryside, summer evening atmosphere. She wears a silky off-white long-sleeve blouse with soft billowing sleeves, tucked into high-waisted beige trousers. Brown leather belt, gold hoop earrings, layered chunky gold chain necklace. Natural hair texture, soft waves, warm reddish-brown tone, sunlit highlights. 
        
        Expression: relaxed, confident, slightly serious but calm. Soft natural makeup. Hands casually in pockets, relaxed posture, body facing camera. 
        
        Lighting & mood Golden hour sunlight, warm tones, soft cinematic contrast, gentle shadows across face. Rich greens in background, warm sun-kissed skin tone, film-like texture, slightly grainy cinematic look, high-end editorial fashion mood. Composition Mid-length portrait, subject centered slightly off-axis, shallow depth of field, 50mm lens feel, soft background blur. 
        
        Editorial luxury fashion tone, timeless elegance, natural beauty, tactile clothing texture. Important Use her face from the reference. Same outfit, same environment, same lighting style, same mood. Maintain warm golden tone, natural texture, film quality.
            
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
        imageName: "vintagegraysuit",
        imageNameOriginal: "yourphoto",
        
        title: "Vintage Gray Suit",
        cost: 0.05,
        description: "",
        prompt: """
        
        Recreate a nostalgic and elegant scene featuring a uploaded a refrence image man in a gray 3 suite dress leaning against a vintage car on a winding road. Capture the shot with soft, diffused natural lighting, evoking a romantic and vintage mood. Use a medium telephoto lens (50-85mm) with a shallow depth of field (f/2.8-f/4) to blur the background. Apply warm color grading with slightly muted tones in post-processing. Ensure professional quality with high resolution and sharp details on the subject.
            
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

]
