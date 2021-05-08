//
//  HomeDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class HomeDatasource: NSObject, UICollectionViewDataSource {

    weak var collectionView: UICollectionView?
    
    let profileCellRegistration = UICollectionView.CellRegistration<ProfileCell, String> { (cell, indexPath, item) in
        // DO NOTHING
    }
    
    init(for collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: profileCellRegistration, for: indexPath, item: "Profile")
    }

}
