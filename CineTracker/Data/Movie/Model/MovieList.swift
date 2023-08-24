//
//  MovieList.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

struct MovieList: Decodable {

    let results: [Movie]
    let totalPages: Int
}

extension MovieList {

    func toDomainModel(imageBaseURLString: String) -> CTMovieList {
        .init(
            movies: results.map {
                $0.toDomainModel(imageBaseURLString: imageBaseURLString)
            },
            totalPages: totalPages
        )
    }
}
