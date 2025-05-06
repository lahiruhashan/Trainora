//
//  CoreDataSeeder.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/4/25.
//

import Foundation
import CoreData

struct CoreDataSeeder {
//    static func seedInitialWorkout(context: NSManagedObjectContext) {
//        let today = Date().startOfDay
//        print("Seeding for date: \(today)")
//
//        let request: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "date == %@", today as NSDate)
//
//        if let existing = try? context.fetch(request), !existing.isEmpty {
//            print("⚠️ Workout for today already exists, skipping seeding.")
//            return
//        }
//
//        // Create WorkoutEntity
//        let workout = WorkoutEntity(context: context)
//        workout.id = UUID()
//        workout.date = today
//
//        // Define 10 exercises
//        let exerciseData = [
//            ("Mountain Climbers", "figure.run", 110.0, 12.0, "Cardio warm-up"),
//            ("Plank", "flame.fill", 60.0, 5.0, "Core strength"),
//            ("Push-ups", "figure.strengthtraining.traditional", 95.0, 8.0, "Upper body strength"),
//            ("Jumping Jacks", "bolt.heart", 120.0, 10.0, "Full-body cardio"),
//            ("Burpees", "figure.highintensity.intervaltraining", 130.0, 7.0, "High intensity workout"),
//            ("Squats", "figure.strengthtraining.functional", 80.0, 6.0, "Lower body workout"),
//            ("Lunges", "figure.walk", 85.0, 8.0, "Leg day essential"),
//            ("Sit-ups", "figure.core.training", 75.0, 6.0, "Abdominal exercise"),
//            ("Jump Rope", "figure.jumprope", 150.0, 15.0, "Intense cardio"),
//            ("Yoga Stretch", "figure.cooldown", 50.0, 10.0, "Flexibility and cool down")
//        ]
//
//        var exerciseEntities: [ExerciseEntity] = []
//
//        for (title, imageName, calories, duration, description) in exerciseData {
//            let exercise = ExerciseEntity(context: context)
//            exercise.id = UUID()
//            exercise.categoryId = UUID()
//            exercise.title = title
//            exercise.calories = calories
//            exercise.duration = duration
//            exercise.imageName = imageName
//            exercise.reps = 0
//            exercise.isFavorite = false
//            exercise.exerciseDescription = description
//            exercise.workout = workout
//            exerciseEntities.append(exercise)
//        }
//
//        // Optional: Set to workout if inverse isn't auto-managed
//        workout.exercises = NSSet(array: exerciseEntities)
//
//        do {
//            try context.save()
//            print("✅ Seeded workout with 10 exercises for today.")
//        } catch {
//            print("❌ Failed to seed data: \(error)")
//        }
//    }
    
    static func seedExercisesIndividually(context: NSManagedObjectContext) {
        // Check if any exercises already exist to avoid duplicating
        let fetchRequest: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()

        if let existing = try? context.fetch(fetchRequest), !existing.isEmpty {
            print("⚠️ Exercises already exist, skipping seeding.")
            return
        }

        let exerciseData: [(title: String, description: String, calories: Double, duration: Double, imageName: String)] = [
            ("Jumping Jacks", "Full body warm-up", 100, 10, "figure.walk"),
            ("Push Ups", "Upper body strength", 80, 5, "flame.fill"),
            ("Squats", "Legs and glutes", 90, 8, "bolt.fill"),
            ("Lunges", "Leg toning", 85, 7, "hare.fill"),
            ("Sit Ups", "Core training", 70, 6, "circle.grid.cross"),
            ("High Knees", "Cardio burst", 120, 4, "waveform.path.ecg"),
            ("Plank", "Core stability", 60, 5, "square.grid.2x2"),
            ("Mountain Climbers", "Cardio warm-up", 110, 12, "figure.run"),
            ("Burpees", "Full body power", 130, 6, "flame"),
            ("Bicycle Crunches", "Abs and obliques", 75, 5, "figure.core.training")
        ]

        for data in exerciseData {
            let exercise = ExerciseEntity(context: context)
            exercise.id = UUID()
            exercise.categoryId = UUID() // Replace if linking to real categories
            exercise.title = data.title
            exercise.exerciseDescription = data.description
            exercise.calories = data.calories
            exercise.duration = data.duration
            exercise.imageName = data.imageName
            exercise.reps = 0
            exercise.isFavorite = false
        }

        do {
            try context.save()
            print("✅ Successfully seeded 10 standalone exercises.")
        } catch {
            print("❌ Failed to seed exercises: \(error)")
        }
    }

}

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}


