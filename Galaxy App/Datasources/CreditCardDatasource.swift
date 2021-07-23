//
//  CreditCardDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/05/2021.
//

import UIKit
import Gemini

class CreditCardDatasource: NSObject, UICollectionViewDataSource {

    var cards = [Card]()
    
    private let cellRegistration = UICollectionView.CellRegistration<CreditCardCell, Card> { (cell, indexPaht, creditCard) in
        cell.creditCard = creditCard
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cards[indexPath.row])
        
        if let cv = collectionView as? GeminiCollectionView {
            cv.animateCell(cell)
        }
        
        return cell
    }
    

}
