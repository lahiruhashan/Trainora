//
//  WorkoutSaver.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/4/25.
//

import CoreData

struct WorkoutSaver {
    static func saveWorkout(
        for user: UserProfileEntity,
        date: Date,
        exercises: [Exercise],
        context: NSManagedObjectContext
    ) {
        let workout = WorkoutEntity(context: context)
        workout.id = UUID()
        workout.date = date
        workout.user = user

        for ex in exercises {
            let entity = ExerciseEntity(context: context)
            entity.id = UUID()
            entity.title = ex.title
            entity.duration = Double(ex.duration)
            entity.calories = Double(ex.calories)
            entity.imageName = "figure.walk"
            entity.exerciseDescription = "Planned"
            entity.reps = 0
            entity.isFavorite = false
            entity.workout = workout
        }

        do {
            try context.save()
            print("✅ Workout saved successfully.")
        } catch {
            print("❌ Failed to save workout: \(error.localizedDescription)")
        }
    }
}

