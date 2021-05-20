//
//  CastDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 20/05/2021.
//

import UIKit

class CastDatasource: NSObject, UICollectionViewDataSource {
    
    let casts: [Cast]?
    
    init(casts: [Cast]?) {
        self.casts = casts
    }
    
    private let cellRegistration = UICollectionView.CellRegistration<CastCell, Cast?> { (cell, indexPath, item) in
        cell.cast = item
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cast = casts?[indexPath.row]
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cast)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts?.count ?? 0
    }
}
