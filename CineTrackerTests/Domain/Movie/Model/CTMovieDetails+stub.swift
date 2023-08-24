//
//  CTMovieDetails+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension CTMovieDetails {

    static func stub(
        hasAdultContent: Bool = false,
        backdropURL: URL? = nil,
        budget: Int = 0,
        homepageURL: URL? = nil,
        id: Int = 0,
        overview: String = "",
        posterURL: URL? = nil,
        releaseDate: Date? = nil,
        revenue: Int = 0,
        runtime: Int = 0,
        title: String = ""
    ) -> Self {
        .init(
            hasAdultContent: hasAdultContent,
            backdropURL: backdropURL,
            budget: budget,
            homepageURL: homepageURL,
            id: id,
            overview: overview,
            posterURL: posterURL,
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            title: title
        )
    }
}
