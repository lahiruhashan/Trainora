//
//  CoreData+Extensions.swift
//  Trainora
//
//  Created by user266021 on 5/1/25.
//

import Foundation
import CoreData

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

extension UserProfileEntity {
    var experienceLevel: ExperienceLevel {
        get { ExperienceLevel(rawValue: experience ?? "beginner") ?? .beginner }
        set { experience = newValue.rawValue }
    }
    
    var genderEnum: Gender {
        get { Gender(rawValue: gender ?? "other") ?? .other }
        set { gender = newValue.rawValue }
    }
    
    func toDomain() -> UserProfile {
        return UserProfile(
            id: id ?? UUID(),
            firstName: firstName ?? "",
            lastName: lastName ?? "",
            email: email ?? "",
            mobileNumber: mobileNumber ?? "",
            password: password ?? "",
            dateOfBirth: dateOfBirth ?? Date(),
            weight: Double(weight),
            height: Double(height),
            profileImageName: profileImageName ?? "",
            experience: experienceLevel,
            gender: genderEnum,
            age: Int(age)
        )
    }

    func update(from profile: UserProfile) {
        self.id = profile.id
        self.firstName = profile.firstName
        self.lastName = profile.lastName
        self.email = profile.email
        self.mobileNumber = profile.mobileNumber
        self.password = profile.password
        self.dateOfBirth = profile.dateOfBirth
        self.weight = profile.weight
        self.height = profile.height
        self.profileImageName = profile.profileImageName
        self.experienceLevel = profile.experience
        self.genderEnum = profile.gender
        self.age = Int16(profile.age)
    }
}

extension Double {
    var roundedToTwoDecimals: String {
        String(format: "%.2f", self)
    }
}
