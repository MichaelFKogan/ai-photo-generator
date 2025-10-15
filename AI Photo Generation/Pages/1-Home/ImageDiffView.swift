//
//  ImageDiffView.swift
//  AI Photo Generation
//
//  Created by AI Assistant on 10/14/25.
//

import SwiftUI

enum ImageDiffAnimation {
    case scanHorizontal
    case scanVertical
    case scanHorizontalVarying
    case scanVerticalVarying
    case crossfade
    case slider
    case flipCard
    case cubeTurn
}

struct ImageDiffView: View {
    let originalImageName: String
    let transformedImageName: String
    let width: CGFloat
    let height: CGFloat
    let animation: ImageDiffAnimation
    
    @State private var scanPosition: CGFloat = 0
    @State private var scanPositionVertical: CGFloat = 0
    @State private var fadeToOriginal: Bool = false
    @State private var sliderPosition: CGFloat? = nil
    @State private var flipAngle: Double = 0
    @State private var cubeAngle: Double = 0
    @State private var scanHorizontalDuration: Double = 2.5
    @State private var scanVerticalDuration: Double = 2.5
    
    var body: some View {
        ZStack {
            switch animation {
            case .scanHorizontal:
                scanningHorizontal
            case .scanVertical:
                scanningVertical
            case .scanHorizontalVarying:
                scanningHorizontal
            case .scanVerticalVarying:
                scanningVertical
            case .crossfade:
                crossfade
            case .slider:
                slider
            case .flipCard:
                flipCard
            case .cubeTurn:
                cubeTurn
            }
        }
        .frame(width: width, height: height)
        .clipped()
        .onAppear {
            startIfNeeded()
        }
    }
    
    // MARK: - Variants
    
    private var scanningHorizontal: some View {
        ZStack(alignment: .leading) {
            Image(transformedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
            
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
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 3)
                .frame(height: height)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                .offset(x: scanPosition)
        }
    }
    
    private var scanningVertical: some View {
        ZStack(alignment: .top) {
            Image(transformedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
            
            Image(originalImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .mask(
                    Rectangle()
                        .frame(height: scanPositionVertical)
                        .frame(maxHeight: .infinity, alignment: .top)
                )
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 3)
                .frame(width: width)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                .offset(y: scanPositionVertical)
        }
    }
    
    private var crossfade: some View {
        ZStack {
            Image(transformedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
            
            Image(originalImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .opacity(fadeToOriginal ? 1.0 : 0.0)
        }
    }
    
    private var slider: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            ZStack(alignment: .leading) {
                Image(transformedImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                
                let currentX = sliderPosition ?? totalWidth * 0.5
                
                Image(originalImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                    .mask(
                        Rectangle()
                            .frame(width: currentX)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    )
                
                // Handle
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 3)
                        .frame(height: height)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
                }
                .contentShape(Rectangle())
                .offset(x: currentX - 1.5)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let newX = min(max(0, value.location.x), totalWidth)
                            sliderPosition = newX
                        }
                )
            }
        }
        .frame(width: width, height: height)
    }
    
    private var flipCard: some View {
        ZStack {
            // Front: original
            Image(originalImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .opacity(flipAngle < 90 ? 1 : 0)
            
            // Back: transformed
            Image(transformedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .opacity(flipAngle >= 90 ? 1 : 0)
        }
        .rotation3DEffect(
            .degrees(flipAngle),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.6
        )
    }
    
    private var cubeTurn: some View {
        ZStack {
            // Leading face: original
            Image(originalImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .rotation3DEffect(
                    .degrees(cubeAngle),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .leading,
                    perspective: 0.6
                )
                .opacity(cubeAngle <= 90 ? 1 : 0)
            
            // Trailing face: transformed
            Image(transformedImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .rotation3DEffect(
                    .degrees(cubeAngle - 180),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .trailing,
                    perspective: 0.6
                )
                .opacity(cubeAngle > 90 ? 1 : 0)
        }
    }
    
    // MARK: - Animation Control
    
    private func startIfNeeded() {
        switch animation {
            
            
        case .scanHorizontal:
            scanPosition = 0
            withAnimation(
                Animation
                    .easeInOut(duration: 1.25)
                    .repeatForever(autoreverses: true)
            ) {
                scanPosition = width
            }
            
            
        case .scanVertical:
            scanPositionVertical = 0
            withAnimation(
                Animation
                    .easeInOut(duration: 1.25)
                    .repeatForever(autoreverses: true)
            ) {
                scanPositionVertical = height
            }
        case .scanHorizontalVarying:
            scanHorizontalDuration = Double.random(in: 1.0...2.0)
            scanPosition = 0
            withAnimation(
                Animation
                    .easeInOut(duration: scanHorizontalDuration)
                    .repeatForever(autoreverses: true)
            ) {
                scanPosition = width
            }
        case .scanVerticalVarying:
            scanVerticalDuration = Double.random(in: 1.0...2.0)
            scanPositionVertical = 0
            withAnimation(
                Animation
                    .easeInOut(duration: scanVerticalDuration)
                    .repeatForever(autoreverses: true)
            ) {
                scanPositionVertical = height
            }
            
        case .crossfade:
            fadeToOriginal = false
            withAnimation(
                Animation
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
            ) {
                fadeToOriginal = true
            }
            
            
        case .cubeTurn:
            cubeAngle = 0
            withAnimation(
                Animation
                    .easeInOut(duration: 4)
                    .repeatForever(autoreverses: true)
            ) {
                cubeAngle = 180
            }
            
        case .flipCard:
            flipAngle = 0
            withAnimation(
                Animation
                    .easeInOut(duration: 3.5)
                    .repeatForever(autoreverses: true)
            ) {
                flipAngle = 180
            }
            
            
        case .slider:
            // Initialize slider to middle
            sliderPosition = width * 0.5
        }
    }
}


