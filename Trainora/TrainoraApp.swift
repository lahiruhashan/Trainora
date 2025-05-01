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
    
    // code for sample data insert.
    /*
    init() {
        let context = persistenceController.container.viewContext
        let seeder = SampleDataSeeder(context: context)

        
            if let url = Bundle.main.url(forResource: "beginner_sample_data", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let categories = json["categories"] as? [[String: Any]],
               let exercises = json["exercises"] as? [[String: Any]] {
                
                seeder.seed(categories: categories, exercises: exercises)
                UserDefaults.standard.set(true, forKey: "didSeedSampleData")
            }
    }
     */

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
