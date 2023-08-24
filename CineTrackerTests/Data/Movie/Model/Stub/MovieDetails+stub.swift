//
//  MovieDetails+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension MovieDetails {

    static func stub(
        adult: Bool = false,
        backdropPath: String = "",
        budget: Int = 0,
        homepage: String = "",
        id: Int = 0,
        overview: String = "",
        posterPath: String = "",
        releaseDate: String = "",
        revenue: Int = 0,
        runtime: Int = 0,
        title: String = ""
    ) -> Self {
        .init(
            adult: adult,
            backdropPath: backdropPath,
            budget: budget,
            homepage: homepage,
            id: id,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            title: title
        )
    }
}
