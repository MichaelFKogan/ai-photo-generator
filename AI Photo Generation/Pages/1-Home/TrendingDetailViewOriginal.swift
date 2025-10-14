// //
// //  TrendingDetailView.swift
// //  AI Photo Generation
// //
// //  Created by Mike K on 10/10/25.
// //

// import SwiftUI
// import PhotosUI

// struct TrendingDetailView: View {
//     let item: TrendingItem
//     @State private var prompt: String = ""
//     @State private var isGenerating: Bool = false
//     @State private var selectedImage: UIImage?
//     @State private var selectedPhotoItem: PhotosPickerItem?
//     @State private var showCamera: Bool = false
//     @State private var showPhotoPicker: Bool = false // <-- new state

//     var body: some View {
//         ScrollView {
//             VStack(spacing: 24) {
//                 VStack(spacing: 12){
//                     // Top Hero Banner (full-width, taller, dark overlay)
//                     Image(item.imageName)
//                         .resizable()
//                         .aspectRatio(contentMode: .fill)
//                         .frame(height: 360)
//                         .frame(maxWidth: .infinity)
//                         .clipped()
//                         .overlay(Color.black.opacity(0.3))

//                     // Add Photo Button below the banner
//                     AddPhotoButton(
//                         selectedImage: $selectedImage,
//                         selectedPhotoItem: $selectedPhotoItem,
//                         showCamera: $showCamera,
//                         showPhotoPicker: $showPhotoPicker
//                     )
//                     .frame(height: 180)
//                     .frame(maxWidth: .infinity)
//                     .padding(.horizontal)
//                 }
                
//                 VStack(alignment: .leading, spacing: 16) {
                    
// //                    PromptSection(prompt: $prompt)
                    
//                     GenerateButton(
//                         isGenerating: $isGenerating,
//                         selectedImage: selectedImage,
//                         prompt: prompt
//                     )
                    
// //                    // AI Model Section
// //                    AIModelSection(modelName: item.modelName, modelDescription: item.modelDescription, modelImageName: item.modelImageName)
                    
//                     ExampleImagesSection(images: item.exampleImages)
//                 }
//                 .padding(.horizontal)
//             }
//             .padding(.bottom)
//         }
//         .ignoresSafeArea(edges: .top)
//         .navigationTitle(item.title)
//         .navigationBarTitleDisplayMode(.inline)
//         .sheet(isPresented: $showCamera) {
//             ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
//         }
//         .onChange(of: selectedPhotoItem) { newItem in
//             Task {
//                 if let data = try? await newItem?.loadTransferable(type: Data.self),
//                    let uiImage = UIImage(data: data) {
//                     selectedImage = uiImage
//                 }
//             }
//         }
//         .onAppear {
//             prompt = item.prompt
//         }
//     }
// }

// // MARK: - Add Photo Button
// struct AddPhotoButton: View {
//     @Binding var selectedImage: UIImage?
//     @Binding var selectedPhotoItem: PhotosPickerItem?
//     @Binding var showCamera: Bool
//     @Binding var showPhotoPicker: Bool
    
//     var body: some View {
//         if let selectedImage = selectedImage {
//             // Show selected image with remove button
//             ZStack(alignment: .topTrailing) {
//                 Image(uiImage: selectedImage)
//                     .resizable()
//                     .aspectRatio(contentMode: .fill)
//                     .clipShape(RoundedRectangle(cornerRadius: 12))
//                     .overlay(
//                         RoundedRectangle(cornerRadius: 12)
//                             .stroke(Color.blue, lineWidth: 2)
//                     )
                
//                 Button(action: { self.selectedImage = nil }) {
//                     Image(systemName: "xmark.circle.fill")
//                         .font(.title3)
//                         .foregroundColor(.white)
//                         .background(Circle().fill(Color.red))
//                 }
//                 .padding(6)
//             }
//         } else {
//             // Show "Add A Photo" button with menu
//             Menu {
//                 Button(action: { showCamera = true }) {
//                     Label("Take Photo", systemImage: "camera")
//                 }
                
//                 Button(action: { showPhotoPicker = true }) {
//                     Label("Choose from Library", systemImage: "photo.on.rectangle.angled")
//                 }
//             } label: {
//                 VStack(spacing: 16) {
//                     // Icon with plus badge
//                     ZStack(alignment: .bottomTrailing) {
//                         Image(systemName: "photo.on.rectangle")
//                             .font(.system(size: 50))
//                             .foregroundColor(.gray.opacity(0.4))
//                     }
                    
//                     VStack(spacing: 4) {
//                         Text("Add A Photo")
//                             .font(.subheadline)
//                             .fontWeight(.medium)
//                             .foregroundColor(.gray)
                        
//                         Text("Tap to upload or take")
//                             .font(.caption2)
//                             .foregroundColor(.gray.opacity(0.7))
//                     }
//                 }
//                 .frame(maxWidth: .infinity, maxHeight: .infinity)
//                 .background(Color.gray.opacity(0.03))
//                 .clipShape(RoundedRectangle(cornerRadius: 12))
//                 .overlay(
//                     RoundedRectangle(cornerRadius: 12)
//                         .strokeBorder(style: StrokeStyle(lineWidth: 3.5, dash: [6, 4]))
//                         .foregroundColor(.gray.opacity(0.4))
//                 )
//             }
//             .photosPicker(
//                 isPresented: $showPhotoPicker,
//                 selection: $selectedPhotoItem,
//                 matching: .images
//             )
//             .onChange(of: selectedPhotoItem) { newItem in
//                 Task {
//                     if let data = try? await newItem?.loadTransferable(type: Data.self),
//                        let uiImage = UIImage(data: data) {
//                         selectedImage = uiImage
//                     }
//                 }
//             }
//         }
//     }
// }

// // MARK: - Photo Upload Section
// struct PhotoUploadSection: View {
//     @Binding var selectedImage: UIImage?
//     @Binding var showCamera: Bool
//     @Binding var showPhotoPicker: Bool

//     @State private var selectedPhotoItem: PhotosPickerItem?

//     var body: some View {
//         VStack(alignment: .leading, spacing: 8) {
//             Text("Upload or Take Photo")
//                 .font(.headline)
//                 .foregroundColor(.secondary)

//             if let selectedImage = selectedImage {
//                 ZStack(alignment: .topTrailing) {
//                     Image(uiImage: selectedImage)
//                         .resizable()
//                         .aspectRatio(contentMode: .fill)
//                         .frame(height: 200)
//                         .clipShape(RoundedRectangle(cornerRadius: 12))
//                         .overlay(
//                             RoundedRectangle(cornerRadius: 12)
//                                 .stroke(Color.blue, lineWidth: 2)
//                         )

//                     Button(action: { self.selectedImage = nil }) {
//                         Image(systemName: "xmark.circle.fill")
//                             .font(.title2)
//                             .foregroundColor(.white)
//                             .background(Circle().fill(Color.red))
//                     }
//                     .padding(8)
//                 }
//             } else {
//                 HStack(spacing: 12) {
//                     // Camera Button
//                     Button(action: { showCamera = true }) {
//                         VStack(spacing: 6) {
//                             Image(systemName: "camera")
//                                 .font(.system(size: 24))
//                             Text("Take Photo")
//                                 .font(.caption2)
//                         }
//                         .frame(maxWidth: .infinity, minHeight: 80)
//                         .background(Color.gray.opacity(0.1))
//                         .clipShape(RoundedRectangle(cornerRadius: 12))
//                     }

//                     // Photo Library Button
//                     Button(action: { showPhotoPicker = true }) {
//                         VStack(spacing: 6) {
//                             Image(systemName: "photo.on.rectangle.angled")
//                                 .font(.system(size: 24))
//                             Text("Choose Photo")
//                                 .font(.caption2)
//                         }
//                         .frame(maxWidth: .infinity, minHeight: 80)
//                         .background(Color.gray.opacity(0.1))
//                         .clipShape(RoundedRectangle(cornerRadius: 12))
//                     }
//                     .photosPicker(
//                         isPresented: $showPhotoPicker,
//                         selection: $selectedPhotoItem,
//                         matching: .images
//                     )
//                     .onChange(of: selectedPhotoItem) { newItem in
//                         Task {
//                             if let data = try? await newItem?.loadTransferable(type: Data.self),
//                                let uiImage = UIImage(data: data) {
//                                 selectedImage = uiImage
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }

// // MARK: - AI Model Section
// struct AIModelSection: View {
//     let modelName: String
//     let modelDescription: String
//     let modelImageName: String
//     let price: Double?
//     let priceCaption: String?

//     init(
//         modelName: String,
//         modelDescription: String,
//         modelImageName: String,
//         price: Double? = nil,
//         priceCaption: String? = nil
//     ) {
//         self.modelName = modelName
//         self.modelDescription = modelDescription
//         self.modelImageName = modelImageName
//         self.price = price
//         self.priceCaption = priceCaption
//     }

//     var body: some View {
//         VStack(spacing: 12) {
            
// //            HStack{
// //                Spacer()
// //                // Optional price caption (e.g., "Price per 8s video" or "Price per image")
// //                if let priceCaption = priceCaption {
// //                    HStack {
// //                        Spacer()
// //                        Text(priceCaption)
// //                            .font(.caption)
// //                            .foregroundColor(.secondary)
// //                    }
// //                }
// //            }

//             HStack(alignment: .top) {
//                 // Model Image on the left
//                 Image(modelImageName)
//                     .resizable()
//                     .aspectRatio(contentMode: .fill)
//                     .frame(width: 100, height: 100)
//                     .clipShape(RoundedRectangle(cornerRadius: 10))
                
//                 // Model name and description on the right
//                 VStack(alignment: .leading, spacing: 6) {
                    
//                     HStack(alignment: .top) {
//                         Text(modelName)
//                             .font(.headline)
//                             .fontWeight(.semibold)
//                             .foregroundColor(.primary)
//                             .lineLimit(2)
//                             .multilineTextAlignment(.leading)
                        
//                         Spacer()
                        
//                         // Optional price badge on the trailing side
//                         if let price = price {
//                             Text(String(format: "$%.2f", price))
//                                 .font(.caption)
//                                 .foregroundColor(.white)
//                                 .padding(.horizontal, 8)
//                                 .padding(.vertical, 4)
//                                 .background(Color.black)
//                                 .cornerRadius(6)
//                         }
//                     }
                    
//                     Text(modelDescription)
//                         .font(.subheadline)
//                         .foregroundColor(.secondary)
//                         .lineLimit(3)
//                         .fixedSize(horizontal: false, vertical: true)
//                         .multilineTextAlignment(.leading)
//                 }
                
//                 Spacer()
//             }
//             .padding(12)
//             .background(Color(UIColor.secondarySystemGroupedBackground))
//             .cornerRadius(12)
//             .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
//         }
//     }
// }

// // MARK: - Prompt Section
// struct PromptSection: View {
//     @Binding var prompt: String

//     var body: some View {
//         VStack(alignment: .leading, spacing: 8) {
//             Text("Prompt")
//                 .font(.headline)
//                 .foregroundColor(.secondary)

//             TextEditor(text: $prompt)
//                 .font(.system(size: 14)).opacity(0.8)
//                 .frame(minHeight: 120)
//                 .padding(8)
//                 .background(Color.gray.opacity(0.1))
//                 .clipShape(RoundedRectangle(cornerRadius: 12))
//                 .overlay(
//                     RoundedRectangle(cornerRadius: 12)
//                         .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                 )
//         }
//     }
// }

// // MARK: - Generate Button
// struct GenerateButton: View {
//     @Binding var isGenerating: Bool
//     let selectedImage: UIImage?
//     let prompt: String

//     var body: some View {
//         Button(action: {
//             isGenerating = true
//             DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                 isGenerating = false
//             }
//         }) {
//             HStack {
//                 if isGenerating {
//                     ProgressView()
//                         .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                         .scaleEffect(0.8)
//                 } else {
//                     Image(systemName: "wand.and.stars")
//                 }
//                 Text(isGenerating ? "Generating..." : "Generate Image")
//                     .fontWeight(.semibold)
//             }
//             .frame(maxWidth: .infinity)
//             .padding()
//             .background(isGenerating || selectedImage == nil || prompt.isEmpty ? Color.gray : Color.blue)
//             .foregroundColor(.white)
//             .clipShape(RoundedRectangle(cornerRadius: 12))
//         }
//         .disabled(isGenerating || selectedImage == nil || prompt.isEmpty)
//         .opacity(selectedImage == nil || prompt.isEmpty ? 0.6 : 1.0)
//     }
// }

// // MARK: - Example Images Section
// struct ExampleImagesSection: View {
//     let images: [String]

//     var body: some View {
//         VStack(alignment: .leading, spacing: 12) {
//             Text("Example Images")
//                 .font(.title3)
//                 .fontWeight(.semibold)
//                 .padding(.top, 8)

//             LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
//                 ForEach(images, id: \.self) { imageName in
//                     Image(imageName)
//                         .resizable()
//                         .aspectRatio(1, contentMode: .fill)
//                         .clipShape(RoundedRectangle(cornerRadius: 12))
//                         .overlay(
//                             RoundedRectangle(cornerRadius: 12)
//                                 .stroke(Color.gray.opacity(0.2), lineWidth: 1)
//                         )
//                 }
//             }
//         }
//     }
// }

// // MARK: - ImagePicker for Camera
// struct ImagePicker: UIViewControllerRepresentable {
//     let sourceType: UIImagePickerController.SourceType
//     @Binding var selectedImage: UIImage?
//     @Environment(\.dismiss) private var dismiss

//     func makeUIViewController(context: Context) -> UIImagePickerController {
//         let picker = UIImagePickerController()
//         picker.sourceType = sourceType
//         picker.delegate = context.coordinator
//         return picker
//     }

//     func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

//     func makeCoordinator() -> Coordinator {
//         Coordinator(self)
//     }

//     class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//         let parent: ImagePicker
//         init(_ parent: ImagePicker) { self.parent = parent }

//         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//             if let image = info[.originalImage] as? UIImage {
//                 parent.selectedImage = image
//             }
//             parent.dismiss()
//         }

//         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//             parent.dismiss()
//         }
//     }
// }

