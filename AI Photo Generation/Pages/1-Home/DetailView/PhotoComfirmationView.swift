import SwiftUI

struct PhotoConfirmationView: View {
    let image: UIImage
    let cost: String
    
    @State private var shimmer: Bool = false
    @State private var sparklePulse: Bool = false
    @State private var generatePulse: Bool = false
    
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
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 2
                            )
                    )
                    .scaleEffect(generatePulse ? 1.02 : 1.0)
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: generatePulse)
                
                // MARK: - Generate Button
                Button(action: {
                    print("Generate pressed")
                }) {
                    Text("Generate")
                        .font(.custom("Nunito-ExtraBold", size: 22))
                        .foregroundColor(.black)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.white)
//                        .background(
//                            LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
//                        )
                        .cornerRadius(12)
                        .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
                        .scaleEffect(generatePulse ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: generatePulse)
                }
                .padding(.horizontal, 24)
                .onAppear { generatePulse = true }
                
                // MARK: - Cost Display
                HStack {
                    Spacer()
                    Image(systemName: "tag.fill")
                        .foregroundStyle(
                            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    Text("Cost: $\(cost)")
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
