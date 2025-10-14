//
//  ScanningImageView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/14/25.
//

import SwiftUI

struct ScanningImageView: View {
    let originalImageName: String
    let transformedImageName: String
    let width: CGFloat
    let height: CGFloat
    
    @State private var scanPosition: CGFloat = 0
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Base layer: Transformed image (right side)
                Image(transformedImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                
                // Mask layer: Original image (left side) - revealed by scan position
                Image(originalImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                    .mask(
                        Rectangle()
                            .frame(width: scanPosition)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    )
                
                // Scanning white line
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 3)
                    .frame(height: height)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                    .offset(x: scanPosition)
            }
            .frame(width: width, height: height)
            .onAppear {
                startAnimation()
            }
        }
        .frame(width: width, height: height)
    }
    
    private func startAnimation() {
        // Start from left
        scanPosition = 0
        
        // Animate to the right, then back to left, repeating
        withAnimation(
            Animation
                .easeInOut(duration: 2.0)
                .repeatForever(autoreverses: true)
        ) {
            scanPosition = width
        }
    }
}

