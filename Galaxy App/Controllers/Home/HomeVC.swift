//
//  HomeVC.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: HomeCoordinator?
    var user: SignInUserData? {
        didSet {
            dataSource.user = user
        }
    }

    private lazy var dataSource = HomeDatasource()

    // MARK: - Views
    
    let navView = UIView(backgroundColor: .systemBackground)
    
    let menuButton = UIButton(iconImage: #imageLiteral(resourceName: "menu"))
    
    lazy var collectionView: UICollectionView = {
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
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        
        fetchNowShowingMovies(then: setter(for: self, keyPath: \.dataSource.nowShowingMovies))
        fetchComingMovies(then: setter(for: self, keyPath: \.dataSource.comingSoonMovies))
    }
    
    // MARK: - Private Helpers
    
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
    
    private func fetchNowShowingMovies(then completion: @escaping ([Movie]) -> Void) {
        spinner.startAnimating()
        ApiService.shared.fetchMovies { [weak self] result in
            do {
                let response = try result.get()
                completion(response.movies ?? [])
                self?.collectionView.reloadData()
                self?.spinner.stopAnimating()
            } catch {
                fatalError("[Error while fetching now showing movies] \(error)")
            }
        }
    }
    
    private func fetchComingMovies(then completion: @escaping ([Movie]) -> Void) {
        ApiService.shared.fetchMovies(movieType: ApiService.MovieFetchType.coming) { [weak self] result in
            do {
                let response = try result.get()
                completion(response.movies ?? [])
                self?.collectionView.reloadData()
            } catch {
                fatalError("[Error while fetching upcoming movies] \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.getMovie(at: indexPath) else { return }
        coordinator?.movieDetail(movie.id)
    }
}
