//
//  MovieEntity+Extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation

extension MovieEntity {
    
    func toMovie() -> Movie {
        let genresArr = genres?.split(separator: ",").map { String($0) }
        return Movie(id: Int(id), originalTitle: originalTitle, releaseDate: releaseDate, genres: genresArr, posterPath: posterPath)
    }
}
