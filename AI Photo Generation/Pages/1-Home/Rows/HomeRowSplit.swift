import SwiftUI

struct HomeRowSplit: View {
    let title: String
    let items: [InfoPacket]
    var diffAnimation: ImageDiffAnimation

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RowTitle(title: title) {
                print("Tapped See All for \(title)")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: ImageDetailView(item: item)) {
                            VStack(spacing: 8) {
                                if let originalImage = item.imageNameOriginal {
                                    ImageAnimations(
                                        originalImageName: originalImage,
                                        transformedImageName: item.imageName,
                                        width: 140,
                                        height: 196,
                                        animation: diffAnimation
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                                    .overlay(alignment: .bottom) {
                                        Text("Try This")
                                            .font(.custom("Nunito-ExtraBold", size: 12))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 5)
                                            .background(Color.black.opacity(0.6))
                                            .clipShape(Capsule())
                                            .padding(.bottom, 6)
                                    }
                                    // ✅ Top-right overlay (Price)
                                    .overlay(alignment: .topTrailing) {
//                                        if let price = item.price {
//                                            Text("$\(price, specifier: "%.2f")")
                                        Text("$\(item.cost, specifier: "%.2f")")
                                                .font(.custom("Nunito-Bold", size: 11))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 3)
                                                .background(Color.black.opacity(0.8))
                                                .clipShape(Capsule())
                                                .padding(6)
//                                        }
                                    }

                                    Text(item.title)
                                        .font(.custom("Nunito-ExtraBold", size: 11))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.primary)
                                } else {
                                    // fallback to regular image if original missing
                                    Image(item.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 140, height: 196)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        )
                                        .overlay(alignment: .bottom) {
                                            Text("Try This")
                                                .font(.custom("Nunito-ExtraBold", size: 12))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 5)
                                                .background(Color.black.opacity(0.6))
                                                .clipShape(Capsule())
                                                .padding(.bottom, 6)
                                        }

                                    Text(item.title)
                                        .font(.custom("Nunito-ExtraBold", size: 11))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
