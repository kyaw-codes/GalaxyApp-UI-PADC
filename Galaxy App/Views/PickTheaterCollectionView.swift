//
//  PickTheaterCollectionView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import UIKit

class PickTheaterCollectionView : UICollectionView {
    
    init() {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            PickTheaterCollectionView.createSection()
        }
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .systemBackground
        self.showsVerticalScrollIndicator = false
        self.alwaysBounceVertical = true
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        self.contentInset.top = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private static func createSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        
        return section
    }
}

