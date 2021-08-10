//
//  BelongToTypeEntity.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import CoreData

protocol BelongToTypeRepository {
    func save(name: String) -> BelongToTypeEntity
    func getMovies(of type: MovieFetchType, completion: @escaping([Movie]) -> Void)
    func getEntity(type: MovieFetchType) -> BelongToTypeEntity
}

final class BelongToTypeRepositoryImpl: BaseRepository, BelongToTypeRepository {
    
    static let shared = BelongToTypeRepositoryImpl()
    
    private var movieMap = [String : BelongToTypeEntity]()
    
    private override init() {
        super.init()
        
        initializeTypes()
    }
    
    private func initializeTypes() {
        let request : NSFetchRequest<BelongToTypeEntity> = BelongToTypeEntity.fetchRequest()
        let result: [BelongToTypeEntity] = try! context.fetch(request)
        
        if result.isEmpty {
            /// Persist to the database
            MovieFetchType.allCases.forEach {
                save(name: $0.rawValue)
            }
        }
        
        /// Load keys on memory
        result.forEach {
            if let key = $0.name {
                movieMap[key] = $0
            }
        }
    }
    
    @discardableResult
    func save(name: String) -> BelongToTypeEntity {
        let entity = BelongToTypeEntity(context: context)
        entity.name = name
        coreData.saveContext()
        return entity
    }
    
    func getMovies(of type: MovieFetchType, completion: @escaping([Movie]) -> Void) {
        if let entities = movieMap[type.rawValue]?.movies {
            let movies: [Movie] = entities.map { ($0 as! MovieEntity).toMovie() }
            completion(movies)
        } else {
            completion([Movie]())            
        }
    }
    
    func getEntity(type: MovieFetchType) -> BelongToTypeEntity {
        if let entity = movieMap[type.rawValue] {
            return entity
        }
        return save(name: type.rawValue)
    }
}
