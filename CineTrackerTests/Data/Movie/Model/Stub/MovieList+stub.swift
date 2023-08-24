//
//  MovieList+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension MovieList {

    static func stub(
        results: [Movie] = [],
        totalPages: Int = 0
    ) -> Self {
        .init(
            results: results, totalPages: totalPages
        )
    }
}
