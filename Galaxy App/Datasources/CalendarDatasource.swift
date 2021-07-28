//
//  CalendarDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class CalendarDatasource: NSObject, UICollectionViewDataSource {
    
    var dates = [CalendarVO]()
    
    var onDaySelected: ((CalendarVO) -> Void)?
    
    lazy var cellRegistration = UICollectionView.CellRegistration<CalendarCell, CalendarVO> { [weak self] (cell, indexPath, calendar) in
        cell.calendar = calendar
        cell.onDaySelected = self?.onDaySelected
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let date = dates[indexPath.row]
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: date)
    }
    
}
