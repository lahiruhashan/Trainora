//
//  UserProfileDataSourceProtocol.swift
//  Trainora
//
//  Created by user266021 on 5/3/25.
//


import Foundationimport CoreDataimport Combineprotocol UserProfileDataSourceProtocol {    func fetchProfile() -> AnyPublisher<UserProfile?, Never>    func saveProfile(_ profile: UserProfile)}final class CoreDataUserProfileDataSource: UserProfileDataSourceProtocol {    private let context: NSManagedObjectContext    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {        self.context = context    }    func fetchProfile() -> AnyPublisher<UserProfile?, Never> {        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()        request.fetchLimit = 1        return Future { promise in            let result = try? self.context.fetch(request).first?.toDomain()            promise(.success(result))        }.eraseToAnyPublisher()    }    func saveProfile(_ profile: UserProfile) {        let request: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()        request.fetchLimit = 1        if let entity = try? context.fetch(request).first {            entity.update(from: profile)        } else {            let newEntity = UserProfileEntity(context: context)            newEntity.update(from: profile)        }        try? context.save()    }}