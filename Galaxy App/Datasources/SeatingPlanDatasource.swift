//
//  SeatingPlanDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class SeatingPlanDatasource: NSObject, UICollectionViewDataSource {
    
    let cellRegistration = UICollectionView.CellRegistration<SeatCell, String> { (cell, indexPath, data) in
        if indexPath.row == 0 || indexPath.row == 7 {
            cell.seatView.backgroundColor = .clear
            cell.seatView.isUserInteractionEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 56
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: "")
    }
    
}
