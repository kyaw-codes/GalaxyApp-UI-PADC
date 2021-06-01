//
//  Movie.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/05/2021.
//

import UIKit

struct AllMovie: Codable {
    var status: String
    var movies: [Movie]
}

struct Movie: Codable {
    var coverImage: String? = nil
    var name: String? = nil
    var primaryGenre: String? = nil
    var secondaryGenre: String? = nil
    var duration: String? = nil
    var imbdRating: Double? = nil
    var plot: String? = nil
    var casts: [Cast]? = nil
}

struct Cast: Codable {
    var image: String? = nil
    var name: String? = nil
}
