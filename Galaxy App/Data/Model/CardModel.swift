//
//  CardModel.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 13/08/2021.
//

import Foundation
import Alamofire

protocol CardModel {
    func saveCard(cardNo: String, cardHolder: String, expirationDate: String, cvc: String, completion: @escaping () -> Void)
}

final class CardModelImpl: BaseModel, CardModel {
    
    static let shared = CardModelImpl()
    
    private let cardRepo = CardRepositoryImpl.shared
    private let userRepo = UserRepositoryImpl.shared
    
    private override init() {
    }
    
    func saveCard(cardNo: String, cardHolder: String, expirationDate: String, cvc: String, completion: @escaping () -> Void) {
        networkAgent.createNewCard(cardNo: cardNo, cardHolder: cardHolder, expirationDate: expirationDate, cvc: cvc) { [weak self] cardResponse in
            do {
                let cards = try cardResponse.get()
                cards.forEach {
                    /// Save all the cards again
                    self?.cardRepo.saveCard(card: $0)
                }
                completion()
            } catch {
                switch error {
                case is AFError:
                    print("[Netowrk Error] \(error)")
                default:
                    print("[Coredata Error] \(error)")
                }
            }
        }
    }
    
    func getAllCards(completion: ([Card]) -> Void) {
        do {
            try userRepo.getLoginUser { [weak self] user in
                let id = user.id!
                try? self?.cardRepo.getCards(byUserId: id) { cards in
                    completion(cards)
                }
            }
        } catch {
            switch error {
            case is AFError:
                print("[Netowrk Error] \(error)")
            default:
                print("[Coredata Error] \(error)")
            }
        }
    }
}
