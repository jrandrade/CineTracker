//
//  MovieDetailsToDomainModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieDetailsToDomainModelTests: XCTestCase {

    var sut: MovieDetails!

    func test_ReturnsCorrectCTMovieDetails_When_CallingToDomainModel() {
        // Arrange
        sut = .init(
            adult: true,
            backdropPath: "/some/backdrop/path",
            budget: 100,
            homepage: "www.example.com",
            id: 10,
            overview: "some overview",
            posterPath: "/some/poster/path",
            releaseDate: "2023/01/10",
            revenue: 300,
            runtime: 20,
            title: "some title"
        )

        // Act
        let result = sut.toDomainModel(imageBaseURLString: "www.image.com")

        // Assert
        XCTAssert(result.hasAdultContent)
        XCTAssertEqual(result.backdropURL, URL(string: "www.image.com/some/backdrop/path"))
        XCTAssertEqual(result.budget, 100)
        XCTAssertEqual(result.overview, "some overview")
        XCTAssertEqual(result.posterURL, URL(string: "www.image.com/some/poster/path"))
        XCTAssertEqual(result.releaseDate, CTDateFormatter.shared.date(from: "2023/01/10", format: .yearMonthDayWithHyphens))
        XCTAssertEqual(result.revenue, 300)
        XCTAssertEqual(result.runtime, 20)
        XCTAssertEqual(result.title, "some title")
    }
}
