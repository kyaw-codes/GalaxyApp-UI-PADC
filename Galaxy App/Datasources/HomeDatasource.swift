//
//  HomeDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class HomeDatasource: NSObject, UICollectionViewDataSource {

    var nowShowingMovies = [Movie]()
    var comingSoonMovies = [Movie]()
    
    var user: SignInUserData?
    
    // MARK: - Cell/Header Registration
    
    private lazy var profileCellRegistration = UICollectionView.CellRegistration<ProfileCell, String> { [weak self] (cell, indexPath, item) in
        cell.name = self?.user?.name
        cell.image = self?.user?.profileImage
    }
    
    private lazy var movieCellRegistration = UICollectionView.CellRegistration<MovieCell, Movie> { [weak self] (cell, indexPath, movie) in
        cell.movie = indexPath.section == 1
            ? self?.nowShowingMovies[indexPath.row]
            : self?.comingSoonMovies[indexPath.row]
    }
    
    private let movieHeaderRegistration = UICollectionView.SupplementaryRegistration<MovieHeader>(elementKind: MovieHeader.kind) { (header, string, indexPath) in
        header.headerText = indexPath.section == 1 ? "Now Showing" : "Coming Soon"
    }
    
    // MARK: - Datasource Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return nowShowingMovies.count
        case 2:
            return comingSoonMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return collectionView.dequeueConfiguredReusableCell(using: profileCellRegistration, for: indexPath, item: "Profile")
        } else {
            let movie = indexPath.section == 1 ? nowShowingMovies[indexPath.row] : comingSoonMovies[indexPath.row]
            return collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: movie)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            return UICollectionReusableView()
        } else {
            return collectionView.dequeueConfiguredReusableSupplementary(using: movieHeaderRegistration, for: indexPath)
        }
    }
    
    // MARK: - Utility Method
    
    func getMovie(at indexPath: IndexPath) -> Movie? {
        if indexPath.section != 0 {
            return indexPath.section == 1 ? nowShowingMovies[indexPath.row] : comingSoonMovies[indexPath.row]
        }
        return nil
    }
}
