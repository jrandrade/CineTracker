//
//  Movie+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension Movie {

    static func stub(
        adult: Bool = false,
        id: Int = 0,
        popularity: Double = 0,
        posterPath: String? = nil,
        releaseDate: String = "",
        title: String = ""
    ) -> Self {
        .init(
            adult: adult,
            id: id,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: title
        )
    }
}
