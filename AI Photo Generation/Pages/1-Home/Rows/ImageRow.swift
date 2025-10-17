import SwiftUI

struct ImageRow: View {
    let title: String
    let items: [TrendingItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.custom("Nunito-Black", size: 20))
                    .padding(.horizontal)
                Spacer()
                Text("See All")
                    .font(.custom("Nunito-Bold", size: 12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .overlay(
                        Capsule()
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    )
                    .padding(.trailing, 2)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: TrendingDetailView(item: item)) {
                            VStack(spacing: 8) {
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
                .padding(.horizontal)
            }
        }
    }
}
