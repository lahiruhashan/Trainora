//
//  CoreDataSeeder.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/4/25.
//

import Foundation
import CoreData

struct CoreDataSeeder {
    static func seedInitialWorkout(context: NSManagedObjectContext) {
        // Check if a workout already exists for today
        let today = Date().startOfDay  // ✅ use date only (00:00 time)
                print("Seeding for date: \(today)")
        
        print(today)

        let request: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", today as NSDate)

        if let existing = try? context.fetch(request), !existing.isEmpty {
            print(existing)
            print("⚠️ Workout for today already exists, skipping seeding.")
            return
        }

        // Create WorkoutEntity
        let workout = WorkoutEntity(context: context)
        workout.id = UUID()
        workout.date = today

        // Create first Exercise
        let exercise1 = ExerciseEntity(context: context)
        exercise1.id = UUID()
        exercise1.categoryId = UUID()
        exercise1.title = "Mountain Climbers"
        exercise1.calories = 110
        exercise1.duration = 12
        exercise1.imageName = "figure.run"
        exercise1.reps = 0
        exercise1.isFavorite = false
        exercise1.exerciseDescription = "Cardio warm-up"
        exercise1.workout = workout // ✅ Link to workout

        // Create second Exercise
        let exercise2 = ExerciseEntity(context: context)
        exercise2.id = UUID()
        exercise2.categoryId = UUID()
        exercise2.title = "Plank"
        exercise2.calories = 60
        exercise2.duration = 5
        exercise2.imageName = "flame.fill"
        exercise2.reps = 0
        exercise2.isFavorite = false
        exercise2.exerciseDescription = "Core strength"
        exercise2.workout = workout // ✅ Link to workout

        // ✅ Optional: explicitly add exercises to workout’s 'exercises' set
        // Only needed if inverse relationship isn't set properly in model
        workout.exercises = NSSet(array: [exercise1, exercise2])



        do {
            try context.save()
            print("✅ Seeded workout with exercises for today.")
        } catch {
            print("❌ Failed to seed data: \(error)")
        }
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

