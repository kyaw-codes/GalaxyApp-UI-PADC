//
//  GenreDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import UIKit

class GenreDatasource: NSObject, UICollectionViewDataSource {
    
    var genres = [String]()

    private let cellRegistration = UICollectionView.CellRegistration<GenreCollectionViewCell, String> { cell, indexPath, item in
        cell.genreName = item
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: genres[indexPath.row])
    }
}
