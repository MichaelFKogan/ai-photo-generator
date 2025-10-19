//
//  AI_Photo_GenerationApp.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI

@main
struct AI_Photo_GenerationApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var authViewModel = AuthViewModel()
    
//    init() {
//        // Print all loaded font families and names
//        for family in UIFont.familyNames.sorted() {
//            print("Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("    Font: \(name)")
//            }
//        }
//    }

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isCheckingSession {
                    // Show a loading indicator while checking session
                    ProgressView()
                        .scaleEffect(1.5)
                } else if authViewModel.isSignedIn {
                    ContentView()
                        .environmentObject(authViewModel)
                        .environmentObject(themeManager)
                        .preferredColorScheme(themeManager.colorScheme)
                } else {
                    SignInView()
                        .environmentObject(themeManager)
                        .preferredColorScheme(themeManager.colorScheme)
                        .environmentObject(authViewModel)
                }
            }
            .animation(.easeInOut, value: authViewModel.isCheckingSession)
            .animation(.easeInOut, value: authViewModel.isSignedIn)
        }
    }
}

