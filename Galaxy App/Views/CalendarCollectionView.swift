//
//  CalendarCollectionView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 01/06/2021.
//

import UIKit

class CalendarCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)

        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = true
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
