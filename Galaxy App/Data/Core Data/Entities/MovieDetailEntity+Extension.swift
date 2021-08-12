//
//  MovieDetailEntity+Extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 10/08/2021.
//

import Foundation

extension MovieDetailEntity {
    
    func toMovieDetail(casts: [Cast]) -> MovieDetail {
        let genresArr = genres?.split(separator: ",").map { String($0) }
        return MovieDetail(id: Int(id), originalTitle: originalTitle, releaseDate: releaseDate, genres: genresArr, overview: overview, rating: rating, runtime: runtime, posterPath: posterPath, casts: casts)
    }
}
