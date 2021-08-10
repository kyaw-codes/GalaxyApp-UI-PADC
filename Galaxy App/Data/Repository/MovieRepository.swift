//
//  MovieRepository.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import Alamofire

protocol MovieRepository {
    
//    func getAllMovies(
//        movieType: MovieFetchType,
//        recieving demand: Int,
//        completion: @escaping ([Movie]) -> Void
//    )
//
//    func getMovieDetail(_ id: Int, completion: @escaping (MovieDetailResponse) -> Void)
}

final class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared = MovieRepositoryImpl()
    
    private let belontToTypeRepo = BelongToTypeRepositoryImpl.shared
    
    private override init() {
    }

    func save(movies: [Movie], of type: MovieFetchType) {
        movies.forEach {
            let entity = MovieEntity(context: context)
            entity.id = Int32($0.id ?? -1)
            entity.genres = $0.genres?.joined(separator: ",")
            entity.originalTitle = $0.originalTitle
            entity.posterPath = $0.posterPath
            entity.releaseDate = $0.releaseDate
            entity.belongToTypeEntity = belontToTypeRepo.getEntity(type: type)
            coreData.saveContext()
        }
    }
    
    func getMovieDetail(by id: Int) {
        /// TODO: - Implement later
    }
}
