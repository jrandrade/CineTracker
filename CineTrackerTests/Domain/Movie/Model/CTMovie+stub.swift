//
//  CTMovie+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

extension CTMovie {

    static func stub(
        hasAdultContent: Bool = false,
        id: Int = 0,
        popularity: Double = 0,
        posterURL: URL? = nil,
        releaseDate: Date? = nil,
        title: String = ""
    ) -> Self {
        .init(
            hasAdultContent: hasAdultContent,
            id: id,
            popularity: popularity,
            posterURL: posterURL,
            releaseDate: releaseDate,
            title: title
        )
    }
}
