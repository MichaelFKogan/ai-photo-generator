This repository is an iOS SwiftUI app called "AI Photo Generation". The goal of these instructions is to help automated coding agents make precise, low-risk changes by documenting the app structure, key files, build/test workflow, and project-specific patterns.

Core architecture (big picture)
- Single-target SwiftUI iOS application. Entry point: `AI_Photo_GenerationApp.swift` which injects a `ThemeManager` as an `EnvironmentObject`.
- UI is organized by top-level views in `ContentView.swift` (tab controller) with five main feature pages under `Pages/`:
  - `Pages/1-Home/` (home feed, `HomeView.swift`, `RowView.swift`, row data under `Row Data/`)
  - `Pages/2-Explore/` (search/explore)
  - `Pages/3-Create/` (`3-CreateView.swift` provides navigation to generation flows)
  - `Pages/4-Playground/` (models and playground UI)
  - `Pages/5-Profile/` (profile & settings)
- Shared static data for AI models is declared in `ModelData/ModelData.swift` (arrays `imageModels`, `videoModels`). Treat this as read-only seed data unless adding new model fixtures.

Important patterns and conventions
- Theme: a single `ThemeManager: ObservableObject` (in `ThemeManager.swift`) controls dark/light mode via `UserDefaults` key `isDarkMode`. Prefer using `@EnvironmentObject var themeManager: ThemeManager` in views and use `themeManager.toggleTheme()` rather than adding ad-hoc color-scheme logic.
- Navigation: top-level tabbing is controlled by `ContentView` using a ZStack + custom `TabBarButton` pattern with explicit view transitions. When adding a new top-level tab, update `ContentView` and the tab bar consistently.
- Assets: images and thumbnails live under `Assets.xcassets/` organized into folders matching UI sections (e.g., `1-Home/`, `4-Models/`). Use the image names referenced in `ModelData.swift` when adding assets.
- Video playback: `HomeView` uses `AVKit` and `VideoPlayer` for looping muted previews. When adding sample videos, put them in `Videos/` and reference by filename (without extension) in `VideoThumbnailView`.
- UI helpers: `RowView` and `Row Data/` contain per-row sample data and animation choices (diffAnimation enum used by `RowView`) — follow existing styles when creating new rows.

Developer workflows (build, run, tests)
- Primary build/run: open the Xcode project/workspace at `AI Photo Generation.xcodeproj` (or via `open AI\ Photo\ Generation.xcodeproj`). Use Xcode (recommended) to run on simulator or device.
- From terminal (macOS): use xcodebuild for CI or scripted builds. Example: `xcodebuild -scheme "AI Photo Generation" -workspace "AI Photo Generation.xcworkspace" -sdk iphonesimulator -configuration Debug build test` (adjust scheme/workspace if you use the project file).
- Unit/UI tests: test targets exist under `AI Photo GenerationTests/` and `AI Photo GenerationUITests/`. Run via Xcode Test navigator or `xcodebuild test` with the appropriate destination. For quick local runs, use the simulator destination, e.g. `-destination 'platform=iOS Simulator,name=iPhone 14'`.

Integration points and external dependencies
- No external package manager files were found (no `Package.swift`, `Podfile`, or CocoaPods/SwiftPM/Carthage manifests). The project uses only system frameworks (SwiftUI, AVKit, Foundation).
- If you add packages, prefer SwiftPM and update the Xcode workspace accordingly.

Editing rules for AI agents (safe, concrete guidance)
- Keep changes localized: modify only the files relevant to a single UI flow or data model. Avoid broad refactors across many SwiftUI views in one change.
- Preserve user defaults keys and asset name strings. Example: do not rename `isDarkMode` or image names referenced in `ModelData.swift` without updating `Assets.xcassets/` accordingly.
- When adding new assets (images/videos), add matching entries to `Assets.xcassets/` and use the same name strings used in code (e.g., `geminiflashimage25` in `ModelData.swift`).
- Follow existing SwiftUI styles: prefer `NavigationView` + `ScrollView` patterns used in `CreateView` and `HomeView`. Use existing helper components (e.g., `RowView`, `TabBarButton`) rather than duplicating behavior.

Examples to cite when making edits
- Add a new top-level tab: update `ContentView.swift` switch-case and add a corresponding `tabButton(...)` row in the tab bar.
- Add a new AI model fixture: append a `Model(...)` entry to `ModelData/ModelData.swift` and add its image to `Assets.xcassets/4-Models/Image Models/`.
- Add a sample looping video for the home feed: put `video3.mp4` in `Videos/` and reference `VideoThumbnailView(videoName: "video3")` where appropriate.

What I couldn't infer (ask the human)
- CI configuration, simulator/device matrix, and the canonical Xcode scheme name used in CI. If you have a preferred scheme/destination, tell me so I can add exact xcodebuild commands.

If this file needs changes or you want more examples (lint rules, CI commands, or a small contributor checklist), tell me which area to expand.
