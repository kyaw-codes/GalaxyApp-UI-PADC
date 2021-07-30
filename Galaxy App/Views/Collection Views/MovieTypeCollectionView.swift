//
//  MovieTypeCollectionView.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import UIKit

class MovieTypeCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var types = [MovieTypeVO]()
    var onMovieTypeSelected: ((MovieTypeVO) -> Void)?
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<TimeslotCell, MovieTypeVO> { [weak self] cell, indexPath, item in
        cell.movieType = item
        cell.onMovieTypeSelected = self?.onMovieTypeSelected
    }
    
    private let headerRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
        header.headerText = "Available In"
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.headerReferenceSize = CGSize(width: self.frame.width, height: 50)
        backgroundColor = .white
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: types[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 80) / 3
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
