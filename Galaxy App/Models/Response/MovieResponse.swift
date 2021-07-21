//
//  MovieResponse.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/07/2021.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try? newJSONDecoder().decode(MovieResponse.self, from: jsonData)

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let message: String?
    let movies: [Movie]?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case message, code
        case movies = "data"
    }
}

// MARK: - Datum
struct Movie: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
    }
}
