//
//  MovieToDomainModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieToDomainModelTests: XCTestCase {

    var sut: Movie!

    func test_ReturnsCorrectCTMovie_When_CallingToDomainModel() {
        // Arrange
        sut = .init(
            adult: true,
            id: 100,
            popularity: 200,
            posterPath: "/some/path",
            releaseDate: "2023/08/20",
            title: "some title"
        )

        // Act
        let result = sut.toDomainModel(imageBaseURLString: "www.example.com")

        // Assert
        XCTAssert(result.hasAdultContent)
        XCTAssertEqual(result.id, 100)
        XCTAssertEqual(result.title, "some title")
        XCTAssertEqual(result.releaseDate, CTDateFormatter.shared.date(from: "2023/08/20", format: .yearMonthDayWithHyphens))
        XCTAssertEqual(result.posterURL, URL(string: "www.example.com/some/path"))
    }
}
