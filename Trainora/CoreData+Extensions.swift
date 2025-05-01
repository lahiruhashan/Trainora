//
//  CoreData+Extensions.swift
//  Trainora
//
//  Created by user266021 on 5/1/25.
//

import Foundation

extension ExerciseCategoryEntity {
    var levelEnum: ExperienceLevel {
        get { ExperienceLevel(rawValue: self.level ?? "") ?? .beginner }
        set { self.level = newValue.rawValue }
    }
    
    func toDomain() -> ExerciseCategory {
        ExerciseCategory(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            imageName: self.imageName ?? "",
            level: levelEnum,
            totalExercises: 0,  // Calculated in service layer
            totalCalories: 0,
            totalDuration: 0,
            isFavorite: self.isFavorite
        )
    }
}


extension ExerciseEntity {
    func toDomain() -> Exercise {
        Exercise(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            description: self.exerciseDescription ?? "",
            duration: Double(self.duration),
            calories: Double(self.calories),
            reps: Int(self.reps),
            videoURL: self.videoURL.flatMap(URL.init(string:)),
            imageName: self.imageName ?? "",
            isFavorite: self.isFavorite,
            categoryId: self.categoryId ?? UUID()
        )
    }
}
