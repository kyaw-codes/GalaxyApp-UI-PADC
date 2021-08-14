//
//  UserRepository.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation
import CoreData

protocol UserRepository {
    
    func saveUser(user: SignInUserData)
    func getUser(by id: Int, completion: (SignInUserData) -> Void) throws
    func getLoginUser(completion: (SignInUserData) -> Void) throws
    func deleteUser(by id: Int)
    func deleteAllUser()
}

class UserRepositoryImpl: BaseRepository, UserRepository {

    static let shared = UserRepositoryImpl()
    
    private override init() {
    }
    
    func saveUser(user: SignInUserData) {
        let userEntity = UserEntity(context: context)
        userEntity.id = Int64(user.id ?? -1)
        userEntity.name = user.name
        userEntity.email = user.email
        userEntity.phone = user.phone
        userEntity.totalExpense = user.totalExpense ?? 0.0
        userEntity.profileImage = user.profileImage
        
        if let cards = user.cards, !cards.isEmpty {
            cards
                .map { $0.toCardEntity() }
                .forEach { userEntity.addToCards($0) }
        }
        
        coreData.saveContext()
    }
    
    func getUser(by id: Int, completion: (SignInUserData) -> Void) throws {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %d", "id", Int64(id))
        
        let result = try context.fetch(fetchRequest)
        completion(result.first!.toSignInUserData())
    }
    
    func getLoginUser(completion: (SignInUserData) -> Void) throws {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let result = try context.fetch(fetchRequest)
        
        if let user = result.first, result.count == 1 {
            completion(user.toSignInUserData())
        } else {
            fatalError("Can't find user or user row inconsistency")
        }
    }

    func deleteUser(by id: Int) {
        let fetchRequest : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %d", "id", Int64(id))
        
        let result = try? context.fetch(fetchRequest)
        
        if let user = result?.first {
            context.delete(user)
            /// Persist the changes
            coreData.saveContext()
        }
    }
    
    func deleteAllUser() {
        let fetchRequest : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let result = try? context.fetch(fetchRequest)
        result?.forEach {
            context.delete($0)
            coreData.saveContext()
        }
    }
}
