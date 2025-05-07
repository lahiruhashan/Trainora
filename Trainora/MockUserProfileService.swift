//
//  MockUserProfileService.swift
//  Trainora
//
//  Created by Lahiru Hashan on 5/7/25.
//

import Foundation
import Combine

final class MockUserProfileService: UserProfileServiceProtocol {
    var mockUserProfile: UserProfile?
    var shouldFailAuthentication = false

    func getUserProfile(email: String, password: String) -> AnyPublisher<UserProfile?, Never> {
        if shouldFailAuthentication {
            return Just(nil).eraseToAnyPublisher()
        } else {
            return Just(mockUserProfile).eraseToAnyPublisher()
        }
    }

    func getUserProfileByEmail(email: String) -> AnyPublisher<UserProfile?, Never> {
        return Just(mockUserProfile).eraseToAnyPublisher()
    }

    func updateUserProfile(_ profile: UserProfile) {
        // No-op for tests
    }

    func updatePassword(for email: String, oldPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
