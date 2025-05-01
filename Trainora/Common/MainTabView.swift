//
//  MainTabView.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/1/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, library, progress, notifications, settings
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            NavigationStack {
                   ExerciseLibraryTabView()
               }
                .tabItem {
                    Label("Library", systemImage: "book.fill")
                }
                .tag(Tab.library)

            PlannerView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
                .tag(Tab.progress)

            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(Tab.notifications)

            ProfileView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tab.settings)
        }
        .accentColor(.blue) // Optional: change active color
    }
}

#Preview {
    MainTabView()
}
