//
//  SeatingPlanDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 23/05/2021.
//

import UIKit

class SeatingPlanDatasource: NSObject, UICollectionViewDataSource {
    
    var seats = [[Seat]]()
    var onSeatTapped: (() -> Void)?
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<SeatCell, Seat> { [weak self] (cell, indexPath, data) in
        cell.seat = data
        cell.onSeatTapped = self?.onSeatTapped
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: seats[indexPath.section][indexPath.item])
    }
    
}
