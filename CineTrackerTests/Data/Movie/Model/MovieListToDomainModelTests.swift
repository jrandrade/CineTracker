//
//  MovieListToDomainModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieListToDomainModelTests: XCTestCase {

    var sut: MovieList!

    func test_ReturnsCorrectCTMovieList_When_CallingToDomainModel() {
        // Arrange
        sut = .init(
            results: [
                .stub(title: "some title 1"),
                .stub(title: "some title 2"),
                .stub(title: "some title 3")
            ],
            totalPages: 10
        )

        // Act
        let result = sut.toDomainModel(imageBaseURLString: "")

        // Assert
        XCTAssertEqual(result.movies.count, 3)
        XCTAssertEqual(result.movies[0].title, "some title 1")
        XCTAssertEqual(result.movies[1].title, "some title 2")
        XCTAssertEqual(result.movies[2].title, "some title 3")
        
        XCTAssertEqual(result.totalPages, 10)
    }
}
