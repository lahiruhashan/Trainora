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
        exercises: [ExerciseEntity],
        context: NSManagedObjectContext
    ) {
        let workout = WorkoutEntity(context: context)
        workout.id = UUID()
        workout.date = date
        workout.user = user

        // Set exercises relationship (many-to-many)
        workout.exercises = NSSet(array: exercises)

        do {
            try context.save()
            print("✅ Workout saved successfully.")
        } catch {
            print("❌ Failed to save workout: \(error.localizedDescription)")
        }
    }
}



