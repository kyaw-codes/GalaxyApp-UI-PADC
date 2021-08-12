//
//  MovieRepository.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import CoreData

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
            entity.id = Int64($0.id ?? -1)
            entity.genres = $0.genres?.joined(separator: ",")
            entity.originalTitle = $0.originalTitle
            entity.posterPath = $0.posterPath
            entity.releaseDate = $0.releaseDate
            entity.belongToTypeEntity = belontToTypeRepo.getEntity(type: type)
            coreData.saveContext()
        }
    }
    
    func save(movieDetail: MovieDetail) {
        let movieDetailEntity: MovieDetailEntity = movieDetail.toMovieDetailEntity(context: context)
        
        /// Find MovieEntity and set casts from movie detail
        getMovie(by: Int(movieDetail.id ?? -1)) { movieEntity in
            if let casts = movieDetail.casts {
                /// Convert casts to entity type
                let castEntities : [CastEntity] = casts.map { $0.toCastEntity(context: self.context) }
                movieEntity?.addToCasts(NSSet(array: castEntities))
            }
            
            /// Set MovieDetailEntity
            movieDetailEntity.id = Int64(movieDetail.id ?? -1)
            movieDetailEntity.originalTitle = movieDetail.originalTitle
            movieDetailEntity.releaseDate = movieDetail.releaseDate
            movieDetailEntity.genres = movieDetail.genres?.joined(separator: ",")
            movieDetailEntity.overview = movieDetail.overview
            movieDetailEntity.rating = movieDetail.rating ?? 0.0
            movieDetailEntity.runtime = movieDetail.runtime ?? 0.0
            movieDetailEntity.posterPath = movieDetailEntity.posterPath
            
            /// Set detail for movie entity
            movieEntity?.detail = movieDetailEntity
        }
        
        /// Persist to the database
        coreData.saveContext()
    }
    
    func getMovie(by id: Int, completion: @escaping (MovieEntity?) -> Void) {
        let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %d", "id", Int64(id))
        
        let entity = try? context.fetch(fetchRequest).first
        completion(entity)
    }
    
    func getMovieDetail(by id: Int, completion: @escaping (MovieDetail?) -> Void) throws {
        let _ = getMovie(by: id) { movieEntity in
            guard let movieEntity = movieEntity else { return }
            
            /// Get casts from entity and then cast it to 'cast' rather than 'cast entity'
            let casts : [Cast]? = movieEntity.casts?.map { ($0 as! CastEntity).toCast() }
            
            /// Convert to movieDetail type
            let detail = movieEntity.detail?.toMovieDetail(casts: casts ?? [Cast]())
            completion(detail)
        }
                
    }
}
