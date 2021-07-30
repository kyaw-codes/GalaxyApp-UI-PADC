//
//  TabHeader.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 06/06/2021.
//

import UIKit

class TabHeader: UICollectionView, UICollectionViewDataSource {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .systemBackground
        
        self.register(TabHeaderCell.self, forCellWithReuseIdentifier: "tabItem")
        
        dataSource = self
        
        self.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabItem", for: indexPath) as? TabHeaderCell else { fatalError() }
        cell.title = indexPath.item == 0 ? "Login" : "Sign in"
        return cell
    }
}
