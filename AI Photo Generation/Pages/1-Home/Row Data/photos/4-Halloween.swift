//
//  4-Halloween.swift
//  AI Photo Generation
//
//  Created by Mike K on 11/9/25.
//

let halloween = [
    InfoPacket(
        title: "Ghostface Filter 1",
        cost: 0.05,
        
        imageName: "ghostfacefilter1",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Transform the image into a cinematic Y2K photo: A woman lies on a red satin bed, clutching a black, 1990s-era corded telephone, her expression intense and pensive. 
        
        A small gold butterfly clip adorns her long hair. She wears layered gold necklaces and a large gold ring. 
        
        The warm glow of a desk lamp softly illuminates a corner of the room, decorated with retro 1990s rock posters. 
        
        Beside her are popcorn and vintage magazines. 
        
        Behind her, in the doorway of a dark corridor, a figure wearing a ghost face costume stands silently, their silhouette partially hidden in shadow, evoking a sense of suspense and fear. 
        
        The photo has the grainy, low-light look of 1990s film, with warm highlights intertwined with deep shadows to create an eerie, dreamlike atmosphere.
        
        """,
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: "3:4",  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Ghostface Filter 2",
        cost: 0.05,
        
        imageName: "ghostfacefilter2",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        
            Convert the imaage into a dreamy Y2K photo. The subject is lying on a pink satin bed, clutching a '90s-style corded telephone. 
        
            A gold butterfly hairpin accents her flowing hair. She accessorizes with delicate gold necklaces and accessories, including a large gold ring. 
        
            The room behind her is girly, filled with '90s-style posters, creating a dreamy atmosphere. Her makeup is simple and elegant, with brown lipstick and lip liner. 
        
            The photo has a grainy '90s feel, and the light source simulates a table lamp in a dimly lit room at night. Next to her is a bowl of popcorn and some '90s-style magazines. 
        
            A figure in a ghost face costume stands behind her, staring at her. His silhouette is dimly lit, standing in the doorway of a dark hallway. The overall dark tone of the image creates an eerie feeling.
        
        """,
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: "3:4",  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Ghostface Polaroid",
        cost: 0.05,
        
        imageName: "ghostfacepolaroid",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Take a photo using a Polaroid camera. The photo should look like a normal photo, without any clear subjects or props. The photo should have a slight blur effect, and the light source should be evenly distributed across the frame, such as a flash in a dark room. Replace the background with a simple white curtain. The subject is photographed with a person wearing a white ghost mask and a black robe. The ghost mask stands behind the subject, with one hand playfully placed on the subject's neck. The subject looks shocked, creating an eerie yet humorous atmosphere. Do not retouch the face.
        
        """,
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: "3:4",  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),
    InfoPacket(
        title: "Camp Crystal Lake",
        cost: 0.05,
        
        imageName: "campcrystallake",
        imageNameOriginal: "yourphoto",
        
        description: "",
        prompt: """
        
        Using reference photo. Do not change my face, facial features, or hair — keep color and length the same. Create a dreamy Y2K-style photo of me standing on a forest path with cabins in the far background. My long hair is in a ponytail. I wear dainty silver necklaces, silver accessories, and chunky silver rings. Outfit: short red 70s gym shorts with white trim, a white “Camp Crystal Lake” ringer sweatshirt with red accents, white knee-high socks with two red stripes, and black-and-white Converse sneakers. Makeup is simple yet glamorous with red gloss and black liner. The photo has a grainy 70s vibe, fallen gold, brown, and red leaves around. Ghostface stands dimly lit behind a tree watching. Add tattoos to my arms, hands, and legs.
        
        """,
        
        endpoint: "https://api.wavespeed.ai/api/v3/google/nano-banana/edit",
        modelName: "Nano Banana",
        modelDescription: "Google's Gemini Flash Image 2.5 model for advanced image transformations",
        modelImageName: "",
        exampleImages: [],  // Add example images here when available
        
        aspectRatio: "3:4",  // Don't include aspect_ratio for this endpoint
        outputFormat: "jpeg",
        enableSyncMode: false,  // nano-banana uses async mode with polling
        enableBase64Output: false
    ),

]
