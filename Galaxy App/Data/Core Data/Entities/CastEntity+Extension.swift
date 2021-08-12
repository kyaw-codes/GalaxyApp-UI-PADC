//
//  CastEntity+Extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 11/08/2021.
//

import Foundation

extension CastEntity {

    func toCast() -> Cast {
        Cast(
            adult: adult,
            gender: Int(gender),
            id: Int(id),
            knownForDepartment: knownForDepartment,
            name: name,
            originalName: originalName,
            popularity: popularity,
            profilePath: profilePath,
            castID: Int(castId),
            character: character,
            creditID: creditID,
            order: Int(order))
    }
}
