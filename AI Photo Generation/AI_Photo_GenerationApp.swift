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
    
    init() {
        // Print all loaded font families and names
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("    Font: \(name)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}

