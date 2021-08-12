//
//  MovieModel.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import Alamofire

protocol MovieModel {
    func getAllMovies(
        movieType: MovieFetchType,
        recieving demand: Int,
        completion: @escaping ([Movie]) -> Void
    )
    
    func getMovieDetail(_ id: Int, completion: @escaping (MovieDetail) -> Void)
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
    
    func getMovieDetail(_ id: Int, completion: @escaping (MovieDetail) -> Void) {
        NetworkAgentImpl.shared.getMovieDetail(id) { [weak self] result in
            do {
                let response = try result.get()
                if let detail = response.data {
                    self?.movieRepo.save(movieDetail: detail)
                    try self?.movieRepo.getMovieDetail(by: id, completion: { detail in
                        if let detail = detail {
                            completion(detail)
                        }
                    })
                }
            } catch {
                switch error {
                case is AFError:
                    fatalError("[Error while fetching movie detail] \(error)")
                default:
                    fatalError("[Error in repo] \(error)")
                }
            }
        }
    }

}
