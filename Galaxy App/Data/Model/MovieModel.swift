//
//  MovieModel.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation

protocol MovieModel {
    func getAllMovies(
        movieType: MovieFetchType,
        recieving demand: Int,
        completion: @escaping ([Movie]) -> Void
    )
    
    func getMovieDetail(_ id: Int, completion: @escaping (MovieDetailResponse) -> Void)
}

final class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared = MovieModelImpl()
    
    private override init() {
    }
    
    private let movieRepo = MovieRepositoryImpl.shared
    private let belongToTypeRepo = BelongToTypeRepositoryImpl.shared
    
    func getAllMovies(movieType: MovieFetchType, recieving demand: Int = 0, completion: @escaping ([Movie]) -> Void) {
        NetworkAgentImpl.shared.fetchMovies(movieType: movieType) { [weak self] result in
            do {
                let result = try result.get()
                self?.movieRepo.save(movies: result.movies ?? [Movie](), of: movieType)
                self?.belongToTypeRepo.getMovies(of: movieType, completion: completion)
            } catch {
                print("[Error while fetching upcoming movies] \(error)")
            }
        }
    }
    
    func getMovieDetail(_ id: Int, completion: @escaping (MovieDetailResponse) -> Void) {
        
    }

}
