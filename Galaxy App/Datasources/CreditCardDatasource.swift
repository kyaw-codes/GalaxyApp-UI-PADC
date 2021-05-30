//
//  CreditCardDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 28/05/2021.
//

import UIKit
import Gemini

class CreditCardDatasource: NSObject, UICollectionViewDataSource {
    
    var creditCards: [CreditCard] = [
        .init(cardHolder: "Jonathan Ive", expireDate: Date.of(dateString: "01/1/2023"), cardNo: "1534539834210348"),
        .init(cardHolder: "Craig Federighi", expireDate: Date.of(dateString: "07/20/2021"), cardNo: "1534539834218014"),
        .init(cardHolder: "Novall Swift", expireDate: Date.of(dateString: "05/1/2025"), cardNo: "1534539834214249")
    ]
    
    private let cellRegistration = UICollectionView.CellRegistration<CreditCardCell, CreditCard> { (cell, indexPaht, creditCard) in
        cell.creditCard = creditCard
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: creditCards[indexPath.row])
        
        if let cv = collectionView as? GeminiCollectionView {
            cv.animateCell(cell)
        }
        
        return cell
    }
    

}
