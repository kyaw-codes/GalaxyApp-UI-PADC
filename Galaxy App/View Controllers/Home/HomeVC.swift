//
//  HomeVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    var coordinator: HomeCoordinator?
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                return self?.createProfileSection()
            } else {
                return self?.createMovieSection()
            }
        }))
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var dataSource = HomeDatasource(for: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleMenuTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: nil)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }

        collectionView.delegate = self
        collectionView.dataSource = dataSource
    }
    
    private func createProfileSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    private func createMovieSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.38), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .none, trailing: .fixed(20), bottom: .none)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        return section
    }
    
    @objc private func handleMenuTapped() {
        // TODO: - Implement tomorrow
        debugPrint("Menu Tapped")
    }
    
}

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.movieDetail(dataSource.getMovie(at: indexPath))
    }
}
