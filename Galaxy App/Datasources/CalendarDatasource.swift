//
//  CalendarDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

class CalendarDatasource: NSObject, UICollectionViewDataSource {
    
    private var calendars: [Calendar] = [
        .init(day: "We", date: "8"),
        .init(day: "Th", date: "9"),
        .init(day: "Fr", date: "10", isToday: true),
        .init(day: "Sa", date: "11"),
        .init(day: "Su", date: "12"),
        .init(day: "Mo", date: "13"),
        .init(day: "Tu", date: "14")
    ]
    
    let cellRegistration = UICollectionView.CellRegistration<CalendarCell, Calendar> { (cell, indexPath, calendar) in
        cell.calendar = calendar
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calendar = calendars[indexPath.row]
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: calendar)
    }
    
    
    
}
