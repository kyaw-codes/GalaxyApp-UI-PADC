//
//  CardRepository.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 12/08/2021.
//

import Foundation
import CoreData

protocol CardRepository {
    
    func saveCard(card: Card)
    func getCards(byUserId id: Int, completion: ([Card]) -> Void) throws
    func deleteAllCards()
}

class CardRepositoryImpl: BaseRepository, CardRepository {

    static let shared = CardRepositoryImpl()
    
    private override init() {
    }
    
    private let userRepo = UserRepositoryImpl.shared
    
    func saveCard(card: Card) {
        let cardEntity = CardEntity(context: context)
        cardEntity.id = Int64(card.id ?? -1)
        cardEntity.cardHolder = card.cardHolder
        cardEntity.cardNumber = card.cardNumber
        cardEntity.expirationDate = card.expirationDate
        cardEntity.cardType = card.cardType
        
        /// Fetch user and add as card owner
        let fetchRequest : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let userEntity = try? context.fetch(fetchRequest)

        cardEntity.owner = userEntity?.first
        userEntity?.first?.addToCards(cardEntity)
        coreData.saveContext()
    }
    
    func getCards(byUserId id: Int, completion: ([Card]) -> Void) throws {
        let fetchRequest: NSFetchRequest<CardEntity> = CardEntity.fetchRequest()
        let entities = try context.fetch(fetchRequest)
        completion(entities.map { $0.toCard() })
    }
    
    func deleteAllCards() {
        let fetchRequest: NSFetchRequest<CardEntity> = CardEntity.fetchRequest()
        let entities = try? context.fetch(fetchRequest)
        
        if let entities = entities, !entities.isEmpty {
            entities.forEach {
                context.delete($0)
            }
            coreData.saveContext()
        }
    }
}
