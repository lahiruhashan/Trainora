//
//  MainTabView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var homeNavigationPath = NavigationPath()
    @State private var settingsNavigationPath = NavigationPath()
    @EnvironmentObject var userSession: UserSession

    enum Tab {
        case home, library, progress, notifications, settings
    }

    var body: some View {
        Group {
            if userSession.currentUser != nil {
                TabView(selection: $selectedTab) {
                    // HOME TAB
                    NavigationStack(path: $homeNavigationPath) {
                        ZStack {
                            HomeView {
                                homeNavigationPath.append("profile")
                            }
                        }
                        .navigationDestination(for: String.self) { route in
                            if route == "profile" {
                                ProfileView(user: userSession.currentUser!)
                                    .environmentObject(userSession)
                            }
                        }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(Tab.home)

                    // LIBRARY TAB
                    NavigationStack {
                        ExerciseLibraryTabView()
                    }
                    .tabItem {
                        Label("Library", systemImage: "book.fill")
                    }
                    .tag(Tab.library)

                    // PROGRESS TAB
                    PlannerView()
                        .tabItem {
                            Label("Progress", systemImage: "chart.bar.fill")
                        }
                        .tag(Tab.progress)

                    // NOTIFICATIONS TAB
                    NotificationsView()
                        .tabItem {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                        .tag(Tab.notifications)

                    // SETTINGS TAB
                    NavigationStack(path: $settingsNavigationPath) {
                        SettingsView()
                    }
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(Tab.settings)
                }
                .accentColor(.blue)
                .onChange(of: selectedTab) { newTab in
                    switch newTab {
                    case .home:
                        homeNavigationPath = NavigationPath()
                    case .settings:
                        settingsNavigationPath = NavigationPath()
                    default:
                        break
                    }
                }
            } else {
                // Show Sign In screen if user is logged out
                SignInView()
            }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(UserSession())
}
