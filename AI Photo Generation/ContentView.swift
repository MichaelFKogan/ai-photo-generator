import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var sortOrder = 0
    @State private var selectedTab = 0
    @State private var previousTab = 0
    @State private var currentTransitionEdge: Edge = .trailing
    @State private var homeResetTrigger = UUID()

    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case 0:
                    Home(resetTrigger: homeResetTrigger)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(
                                    with: .move(edge: .leading)),
                                removal: .opacity.combined(
                                    with: .move(edge: .leading))
                            ))
                case 1:
                    //    ExploreView() // Old Explore page commented out
                    PhotoFiltersView() // New Photo Filters page
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(
                                    with: .move(edge: currentTransitionEdge)),
                                removal: .opacity.combined(
                                    with: .move(
                                        edge: currentTransitionEdge == .leading
                                            ? .trailing : .leading))
                            ))
                //                case 2:
                //                    CreateView()
                //                        .transition(.asymmetric(
                //                            insertion: .opacity.combined(with: .move(edge: currentTransitionEdge)),
                //                            removal: .opacity.combined(with: .move(edge: currentTransitionEdge == .leading ? .trailing : .leading))
                //                        ))
                case 2:
//                    ImageModels(sortOrder: $sortOrder)
//                        .transition(
//                            .asymmetric(
//                                insertion: .opacity.combined(
//                                    with: .move(edge: currentTransitionEdge)),
//                                removal: .opacity.combined(
//                                    with: .move(
//                                        edge: currentTransitionEdge == .leading
//                                            ? .trailing : .leading))
//                            ))
                //                    ModelsView()
                //                    PlaygroundView()
                 AIModelsView()
                     .transition(.asymmetric(
                         insertion: .opacity.combined(with: .move(edge: currentTransitionEdge)),
                         removal: .opacity.combined(with: .move(edge: currentTransitionEdge == .leading ? .trailing : .leading))
                     ))
                case 3:
//                    VideoModels()
//                        .transition(
//                            .asymmetric(
//                                insertion: .opacity.combined(
//                                    with: .move(edge: currentTransitionEdge)),
//                                removal: .opacity.combined(
//                                    with: .move(
//                                        edge: currentTransitionEdge == .leading
//                                            ? .trailing : .leading))
//                            ))
//                    ModelsView()
                 PlaygroundView()
                     .transition(.asymmetric(
                         insertion: .opacity.combined(with: .move(edge: currentTransitionEdge)),
                         removal: .opacity.combined(with: .move(edge: currentTransitionEdge == .leading ? .trailing : .leading))
                     ))
                case 4:
                    ProfileView()
                        .environmentObject(authViewModel)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(
                                    with: .move(edge: currentTransitionEdge)),
                                removal: .opacity.combined(
                                    with: .move(
                                        edge: currentTransitionEdge == .leading
                                            ? .trailing : .leading))
                            ))
                // case 5:
                //                     SettingsView()
                //                         .transition(.asymmetric(
                //                             insertion: .opacity.combined(with: .move(edge: .trailing)),
                //                             removal: .opacity.combined(with: .move(edge: .trailing))
                //                         ))
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environmentObject(notificationManager)

            // Notification Bar (above tab bar)
            VStack {
                Spacer()
                NotificationBar(notificationManager: notificationManager)
                    .padding(.bottom, 55) // add space above tab bar
            }

            // Tab Bar
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    tabButton(icon: "house.fill", title: "Home", index: 0)
                    //                    tabButton(icon: "magnifyingglass", title: "Explore", index: 1)
                    tabButton(
                        icon: "photo.on.rectangle.angled",
                        title: "Photo Filters", index: 1
                    )

                    //                    tabButton(icon: "plus.circle.fill", title: "Create", index: 2)
                    tabButton(
                        icon: "wrench.and.screwdriver", title: "Playground",
                        index: 2
                    )
                    tabButton(
                        icon: "wrench.and.screwdriver", title: "Playground",
                        index: 3
                    )

                    // tabButton(icon: "cpu", title: "AI Models", index: 3)
                    tabButton(icon: "person.fill", title: "My Photos", index: 4)
                    //                     tabButton(icon: "gearshape.fill", title: "Settings", index: 4)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 0)
                //                .background(.ultraThinMaterial)
                .background(
                    ZStack {
                        // Built-in blur effect
                        Color.clear.background(.ultraThinMaterial)

                        // Add a gentle dark gradient for contrast
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black,
                                Color.black,

                                //                                Color.blue,
                                //                                Color.purple

                                //                                Color.black.opacity(0.8),
                                //                                Color.black.opacity(0.4)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
                    .ignoresSafeArea(edges: .bottom)
                )
            }
        }
        .ignoresSafeArea(.keyboard)
    }

    // Tab button helper
    private func tabButton(icon: String, title: String, index: Int) -> some View {
        TabBarButton(icon: icon, title: title, isSelected: selectedTab == index) {
            // If tapping Home tab while already on Home, reset navigation to root
            if index == 0 && selectedTab == 0 {
                homeResetTrigger = UUID()
            }

            let edge: Edge = index < selectedTab ? .leading : .trailing
            currentTransitionEdge = edge
            previousTab = selectedTab
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedTab = index
            }
        }
    }
}

struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
