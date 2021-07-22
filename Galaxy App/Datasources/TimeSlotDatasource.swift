//
//  PickTheaterDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import UIKit

class TimeSlotDatasource: NSObject, UICollectionViewDataSource {
    
    var onCinemaTimeSlotSelected: ((Int, Int) -> Void)?
    
    var cinemas = [CinemaTimeSlotVM]()
    
    private lazy var headerRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] header, _, indexPath in
        header.headerText = self?.cinemas[indexPath.section].cinema
    }
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<TimeslotCell, CinemaTimeSlotVM> { [weak self] cell, indexPath, item in
        cell.indexPath = indexPath
        cell.cinema = item
        cell.onCinemaTimeSlotSelected = self?.onCinemaTimeSlotSelected
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cinemas.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinemas[section].timeslots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cinemas[indexPath.section])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }

}
