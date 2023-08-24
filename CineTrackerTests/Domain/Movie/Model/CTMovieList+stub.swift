//
//  CTMovieList+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension CTMovieList {

    static func stub(
        movies: [CTMovie] = [],
        totalPages: Int = 0
    ) -> Self {
        .init(
            movies: movies,
            totalPages: totalPages
        )
    }
}
