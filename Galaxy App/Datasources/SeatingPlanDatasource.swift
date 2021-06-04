//
//  SeatingPlanDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class SeatingPlanDatasource: NSObject, UICollectionViewDataSource {
    
    private var seats = [Seat]()
    
    override init() {
        super.init()
        
        for i in (0...7) {
            seats.append(Seat(seatNo: "\(i)", row: "A"))
        }
        
        ["B", "C", "D", "E", "F", "G"].forEach {
            for i in (0...7) {
                seats.append(Seat(seatNo: "\(i)", row: $0))
            }
        }
        
        seats[23].isAvailable = false
        seats[24].isAvailable = false
        seats[25].isAvailable = false
    }
    
    private let cellRegistration = UICollectionView.CellRegistration<SeatCell, Seat> { (cell, indexPath, data) in
        cell.seat = data

        if indexPath.row == 0 || indexPath.row == 7 {
            cell.seatView.isUserInteractionEnabled = false
            cell.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: seats[indexPath.row])
    }
    
}
