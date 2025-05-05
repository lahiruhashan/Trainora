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
    @StateObject private var userSession = UserSession()
    @StateObject private var appState = AppState()
    @StateObject private var colorSchemeManager = ColorSchemeManager()
    @StateObject private var localizationManager = LocalizationManager()

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

    /*
    init() {
        let context = persistenceController.container.viewContext
        let profileSeeder = UserProfileSeeder(context: context)

        if let url = Bundle.main.url(forResource: "user_profile_data", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let profileDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    
            profileSeeder.seed(profileDict: profileDict)
            UserDefaults.standard.set(true, forKey: "didSeedUserProfile")
        }
    }
     */

    init() {
        print("HIHI")
        #if DEBUG
            let context = persistenceController.container.viewContext
            CoreDataSeeder.seedInitialWorkout(context: context)
        #endif
        NotificationManager.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isSignedIn {
                    MainTabView()
                } else {
                    SignInView()
                }
            }
            .environment(
                \.managedObjectContext,
                persistenceController.container.viewContext
            )
            .environmentObject(appState)
            .environmentObject(userSession)
            .environmentObject(colorSchemeManager)
            .environmentObject(localizationManager)
            .preferredColorScheme(colorSchemeManager.colorScheme)
        }
    }
}
