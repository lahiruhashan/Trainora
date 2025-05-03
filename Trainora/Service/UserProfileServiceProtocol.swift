//
//  UserProfileServiceProtocol.swift
//  Trainora
//
//  Created by user266021 on 5/3/25.
//


import Foundationimport Combineprotocol UserProfileServiceProtocol {    func getUserProfile() -> AnyPublisher<UserProfile?, Never>    func updateUserProfile(_ profile: UserProfile)}final class UserProfileService: UserProfileServiceProtocol {    private let repository: UserProfileRepositoryProtocol    init(repository: UserProfileRepositoryProtocol) {        self.repository = repository    }    func getUserProfile() -> AnyPublisher<UserProfile?, Never> {        repository.loadProfile()    }    func updateUserProfile(_ profile: UserProfile) {        repository.saveProfile(profile)    }}