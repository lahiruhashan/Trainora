//
//  HomeViewModel.swift
//  Trainora
//
//  Created by Lahiru Hashan on 4/26/25.
//

import Foundation
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    // Published properties - whenever these change, the UI updates
    @Published var motivationalQuote: String = ""
    @Published var workoutOfTheDay: String = ""
    @Published var progressSummary: String = ""
    @Published var plannedWorkoutCount: Int = 3
    
    private let context: NSManagedObjectContext

    // A static list of quotes (you can later load from JSON, API, etc.)
    private let motivationalQuotes = [
        "Push yourself because no one else is going to do it for you.",
        "Success starts with self-discipline.",
        "The body achieves what the mind believes.",
        "Don’t wish for it. Work for it.",
        "Stay consistent. Be unstoppable."
    ]

    init(context: NSManagedObjectContext) {
            self.context = context
            loadHomeScreenData()
            fetchTodayWorkoutCount()
        }

    func loadHomeScreenData() {
        // Randomly pick a motivational quote
        if let randomQuote = motivationalQuotes.randomElement() {
            motivationalQuote = randomQuote
        }

        // Placeholder workout of the day
        workoutOfTheDay = "Upper Body Strength Training - 45 Minutes"

        // Placeholder progress (could later be calculated from CoreData)
        progressSummary = "You have completed 2 out of 5 workouts this week."
    }
    
    func fetchTodayWorkoutCount() {
            let fetchRequest: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()

            // Filter by today’s date
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)

            do {
                let workoutsToday = try context.fetch(fetchRequest)
                for workout in workoutsToday {
                    if let exercises = workout.exercises as? Set<ExerciseEntity> {
                        plannedWorkoutCount = exercises.count
                    }
                }
            } catch {
                print("❌ Failed to fetch today's workouts: \(error)")
                plannedWorkoutCount = 0
            }
        }
    
    // Numeric progress value (0.0 to 1.0 for ProgressView)
    var progressValue: Double {
        // Example: 3 out of 5 workouts done
        return 3.0 / 5.0 // 60%
    }

    // Text for Progress Summary
    var progressText: String {
        let percentage = Int(progressValue * 100)
        return "You have completed \(percentage)% of your weekly goal."
    }

}

