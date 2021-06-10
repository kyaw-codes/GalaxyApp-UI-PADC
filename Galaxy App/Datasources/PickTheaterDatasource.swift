//
//  PickTheaterDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import UIKit

class PickTheaterDatasource: NSObject, UICollectionViewDataSource {
    
    var onButtonSelect: ((IndexPath) -> Void)?
    
    var data: [ChooseTheaterVO]!
    
    init(data: [ChooseTheaterVO]) {
        self.data = data
    }

    private lazy var headerRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] header, _, indexPath in
        header.headerText = self?.data[indexPath.section].title
    }
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<PickTheaterCell, PickTheaterCell.DataModel> { [weak self] cell, indexPath, item in
        cell.data = item
        cell.onButtonSelect = self?.onButtonSelect
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: (data[indexPath.section], indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }

}
