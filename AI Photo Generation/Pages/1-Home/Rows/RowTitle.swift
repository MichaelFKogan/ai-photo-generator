//
//  RowTitle.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import SwiftUI

struct RowTitle: View {
    let title: String
    let showButton: Bool
    let action: (() -> Void)?

    init(title: String, showButton: Bool = true, action: (() -> Void)? = nil) {
        self.title = title
        self.showButton = showButton
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Nunito-ExtraBold", size: 18))
                .padding(.horizontal)

            Spacer()

            if showButton, let action = action {
                RowButton(title: "See All", action: action)
                    .padding(.trailing, 2)
            }
        }
    }
}

struct RowButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.custom("Nunito-Black", size: 14))
                Image(systemName: "chevron.right") // carrot icon
                    .font(.system(size: 14, weight: .bold))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
//            .overlay(
//                Capsule()
//                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
//            )
        }
        .buttonStyle(.plain)
        .padding(.trailing, 2)
    }
}

