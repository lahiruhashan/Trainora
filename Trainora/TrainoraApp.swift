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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
