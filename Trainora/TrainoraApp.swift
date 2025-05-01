//
//  TrainoraApp.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/20/25.
//

import SwiftUI

@main
struct TrainoraApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isSignedIn {
                MainTabView()
                    .environment(
                        \.managedObjectContext,
                        persistenceController.container.viewContext
                    )
                    .environmentObject(appState)
            } else {
                SignInView()
                    .environment(
                        \.managedObjectContext,
                        persistenceController.container.viewContext
                    )
                    .environmentObject(appState)
            }
        }
    }
}
