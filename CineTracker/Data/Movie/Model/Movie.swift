//
//  Movie.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

struct Movie: Decodable {

    let adult: Bool
    let id: Int
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
}

extension Movie {

    func toDomainModel(imageBaseURLString: String) -> CTMovie {
        .init(
            hasAdultContent: adult,
            id: id,
            popularity: popularity,
            posterURL: posterPath.flatMap{ URL(string: imageBaseURLString + $0) },
            releaseDate: CTDateFormatter.shared.date(
                from: releaseDate,
                format: .yearMonthDayWithHyphens
            ),
            title: title
        )
    }
}
