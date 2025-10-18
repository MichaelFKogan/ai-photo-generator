//
//  OverlayBadges.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

//
//  OverlayBadges.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import SwiftUI

/// A small capsule-style overlay shown at the bottom of an image (e.g. “Try This”)
struct BottomBadgeOverlay: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("Nunito-ExtraBold", size: 12))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color.black.opacity(0.8))
            .clipShape(Capsule())
            .padding(.bottom, 6)
    }
}

/// A small capsule overlay shown at the top-right of an image (e.g. price, cost)
struct TopRightBadgeOverlay: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("Nunito-Bold", size: 11))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
//            .background(Color.black.opacity(0.8))
            .clipShape(Capsule())
            .padding(6)
    }
}
