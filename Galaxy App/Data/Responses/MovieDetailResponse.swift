//
//  MovieDetailResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import Foundation
import CoreData

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    let code: Int?
    let message: String?
    let data: MovieDetail?
}

// MARK: - DataClass
struct MovieDetail: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating, runtime: Double?
    let posterPath: String?
    let casts: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
    
    func toMovieDetailEntity(context: NSManagedObjectContext) -> MovieDetailEntity {
        let entity = MovieDetailEntity(context: context)
        entity.id = Int64(id ?? -1)
        entity.originalTitle = originalTitle ?? ""
        entity.releaseDate = releaseDate ?? ""
        entity.genres = genres?.joined(separator: ",")
        entity.overview = overview ?? ""
        entity.rating = rating ?? 0.0
        entity.runtime = runtime ?? 0.0
        entity.posterPath = posterPath ?? ""
        return entity
    }
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    
    func toCastEntity(context: NSManagedObjectContext) -> CastEntity {
        let entity = CastEntity(context: context)
        entity.id = Int64(id ?? -1)
        entity.adult = adult ?? false
        entity.gender = Int16(gender ?? 1)
        entity.knownForDepartment = knownForDepartment ?? ""
        entity.name = name ?? ""
        entity.originalName = originalName ?? ""
        entity.popularity = popularity ?? 0.0
        entity.profilePath = profilePath ?? ""
        entity.castId = Int64(castID ?? -1)
        entity.character = character ?? ""
        entity.creditID = creditID ?? ""
        entity.order = Int64(order ?? -1)
        return entity
    }
}
