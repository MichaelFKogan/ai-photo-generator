import SwiftUI

struct PhotoConfirmationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var notificationManager: NotificationManager
    
    let item: InfoPacket
    let image: UIImage
    
    @State private var shimmer: Bool = false
    @State private var sparklePulse: Bool = false
    @State private var generatePulse: Bool = false
    
    @State private var rotation: Double = 0
    @State private var isAnimating = false
    
    @State private var generatedImage: UIImage? = nil
    @State private var isLoading = false
    
    @State private var arrowWiggle: Bool = false
    @State private var currentNotificationId: UUID? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // MARK: - Animated Title
                ZStack {
                    Text("Confirm Your Photo")
                        .font(.custom("Nunito-Black", size: 28))
                        .foregroundColor(.primary)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.0),
                                    Color.white.opacity(0.9),
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .rotationEffect(.degrees(20))
                            .offset(x: shimmer ? 300 : -300)
                            .mask(
                                Text("Confirm Your Photo")
                                    .font(.custom("Nunito-Black", size: 28))
                            )
                        )
                        .onAppear {
                            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                shimmer.toggle()
                            }
                        }
                    
                    Image(systemName: "sparkles")
                        .foregroundColor(.yellow.opacity(0.9))
                        .offset(x: -80, y: -10)
                        .scaleEffect(sparklePulse ? 1.2 : 0.8)
                        .opacity(sparklePulse ? 1 : 0.7)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: sparklePulse)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .offset(x: 80, y: -5)
                        .scaleEffect(sparklePulse ? 0.9 : 0.6)
                        .opacity(sparklePulse ? 0.95 : 0.6)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(0.3), value: sparklePulse)
                }
                .onAppear { sparklePulse = true }
                
                // MARK: - Main Photo
                // MARK: - Diagonal Overlapping Images
                GeometryReader { geometry in
                    let imageWidth = geometry.size.width * 0.48
                    let imageHeight = imageWidth * 1.38
                    let arrowYOffset = -imageHeight * 0.15
                    
                    ZStack(alignment: .center) {
                        // Right image (example result) - drawn first so it's behind
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: imageWidth, height: imageHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        lineWidth: 2
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.25), radius: 12, x: 4, y: 4)
                            .rotationEffect(.degrees(8))
                            .offset(x: imageWidth * 0.50)

                        // Left image (user's photo) - drawn second so it's on top
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: imageWidth, height: imageHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(
                                        LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        lineWidth: 2
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.25), radius: 12, x: -4, y: 4)
                            .rotationEffect(.degrees(-6))
                            .offset(x: -imageWidth * 0.50)

                        // Arrow with gentle wiggle
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 62, height: 62)
                            .rotationEffect(.degrees(arrowWiggle ? 6 : -6))
                            .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: arrowWiggle)
                            .offset(x: 0, y: arrowYOffset)
                    }
                    .onAppear {
                        arrowWiggle = true
                    }
                    .frame(width: geometry.size.width, height: imageHeight + 20)
                }
                .frame(height: 260)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                if let generated = generatedImage {
                    VStack {
                        Text("Generated Image")
                            .font(.headline)
                        Image(uiImage: generated)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8)
                    }
                }

                
                // MARK: - Generate Button                
                Button(action: {
                    guard !isLoading else { return }
                    
                    // 🎯 Show notification immediately for testing and store its ID
                    let notificationId = notificationManager.showNotification(
                        title: "Transforming Your Photo",
                        message: "Creating your \(item.title)...",
                        progress: 0.0,
                        thumbnailImage: image
                    )
                    currentNotificationId = notificationId
                    
                    Task {
                        isLoading = true
                        defer { isLoading = false }
                        
                        // Simulate progress updates for this specific notification
                        for progress in stride(from: 0.0, through: 1.0, by: 0.1) {
                            try? await Task.sleep(for: .seconds(0.5))
                            notificationManager.updateProgress(progress, for: notificationId)
                            
                            if progress > 0.5 {
                                notificationManager.updateMessage("Almost done! Finalizing your creation...", for: notificationId)
                            }
                        }
                        
                        // Show completion message
                        notificationManager.updateMessage("✅ Transformation complete!", for: notificationId)
                        
                        // ✅ Instead of calling the API, log all the data that would be sent
                          print("""
                          --- WaveSpeed Request Info ---
                          ------------------------------
                          Endpoint: \(item.endpoint)
                          Prompt: \(item.prompt)
                          Aspect Ratio: \(item.aspectRatio ?? "default")
                          Output Format: \(item.outputFormat)
                          Enable Sync Mode: \(item.enableSyncMode)
                          Enable Base64 Output: \(item.enableBase64Output)
                          Cost: \(item.cost)
                          ------------------------------
                          """)

                          // Example log of image info
                          print("Attached image size: \(image.size.width)x\(image.size.height)")
                          print("Image data size: \((image.jpegData(compressionQuality: 0.8)?.count ?? 0) / 1024) KB")
                        
                        print("""
                              ------------------------------
                              """)

                          // 💤 Simulate a short delay for realism
                          try? await Task.sleep(for: .seconds(1.5))

                          // Stop loading
                          isLoading = false
                          print("✅ Mock request complete — no network call made.")
                        
                        /* COMMENTED OUT FOR TESTING - UNCOMMENT TO ENABLE API CALL
                        do {
                            let response = try await sendImageToWaveSpeed(
                                image: image,
                                prompt: item.prompt,
                                aspectRatio: item.aspectRatio,
                                outputFormat: item.outputFormat,
                                enableSyncMode: item.enableSyncMode,
                                enableBase64Output: item.enableBase64Output,
                                endpoint: item.endpoint
                            )
                            
                            print("Image sent. Response received.")
                            
                            if let urlString = response.data.outputs?.first, let url = URL(string: urlString) {
                                print("[WaveSpeed] Fetching generated image…")
                                let (imageData, _) = try await URLSession.shared.data(from: url)
                                generatedImage = UIImage(data: imageData)
                                print("[WaveSpeed] Generated image loaded successfully.")
                                
                                // Save to Supabase
                                let userId = authViewModel.user?.id.uuidString ?? ""
                                let modelName = item.modelName.isEmpty ? "default-model" : item.modelName

                                do {
                                    try await SupabaseManager.shared.client.database
                                        .from("user_images")
                                        .insert([
                                            "user_id": userId,
                                            "image_url": urlString,
                                            "model": modelName
                                        ])
                                        .execute()
                                    print("✅ Image saved for user")
                                } catch {
                                    print("❌ Failed to save image: \(error)")
                                }
                            }
                            else {
                                print("No output URL returned from WaveSpeed.")
                            }
                        } catch {
                            print("WaveSpeed error: \(error)")
                        }
                        isLoading = false
                        */
                    }
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                        }
                        Text("Generate")
                            .font(.custom("Nunito-ExtraBold", size: 22))
                            .foregroundColor(.white)
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(rotation))
                            .drawingGroup()
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
//                    .background(.white)
                    .background(
                        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(12)
                    .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
                    .scaleEffect(generatePulse ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: generatePulse)
                }
                .padding(.horizontal, 24)
                .onAppear {
                    generatePulse = true
                    
                    isAnimating = true
                    // Kick off the first rotation immediately
                    withAnimation(.easeInOut(duration: 1.0)) {
                        rotation += 360
                    }
                    // Then continue spinning every 4 seconds
                    Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 1.0)) {
                            rotation += 360
                        }
                    }
                }


                
                // MARK: - Cost Display
                HStack {
                    Spacer()
                    Image(systemName: "tag.fill")
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    Text("Cost: $\(String(format: "%.2f", item.cost))")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemBackground))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "diamond.fill")
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .font(.system(size: 9))
                        
                        Text("$5.00")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.primary)
                        Text("credits left")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.1))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                }
            }
        }
    }
}
