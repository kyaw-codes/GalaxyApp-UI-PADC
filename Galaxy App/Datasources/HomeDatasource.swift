//
//  HomeDatasource.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 08/05/2021.
//

import UIKit

class HomeDatasource: NSObject, UICollectionViewDataSource {

    private let movies = Bundle.main.decode([AllMovie].self, from: "Movies.json")
    private lazy var nowShowingMovies = movies[0].movies
    private lazy var comingSoonMovies = movies[1].movies
    
    // MARK: - Cell/Header Registration
    
    private let profileCellRegistration = UICollectionView.CellRegistration<ProfileCell, String> { (cell, indexPath, item) in
        // DO NOTHING
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
            return collectionView.dequeueConfiguredReusableCell(using: movieCellRegistration, for: indexPath, item: Movie())
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
        movies[indexPath.section - 1].movies[indexPath.item]
    }
}
