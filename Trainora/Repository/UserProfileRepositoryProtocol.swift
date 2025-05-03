//
//  UserProfileRepositoryProtocol.swift
//  Trainora
//
//  Created by user266021 on 5/3/25.
//


import Combineprotocol UserProfileRepositoryProtocol {    func loadProfile() -> AnyPublisher<UserProfile?, Never>    func saveProfile(_ profile: UserProfile)}final class UserProfileRepository: UserProfileRepositoryProtocol {    private let dataSource: UserProfileDataSourceProtocol    init(dataSource: UserProfileDataSourceProtocol) {        self.dataSource = dataSource    }    func loadProfile() -> AnyPublisher<UserProfile?, Never> {        dataSource.fetchProfile()    }    func saveProfile(_ profile: UserProfile) {        dataSource.saveProfile(profile)    }}