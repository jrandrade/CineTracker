//
//  MovieCollectionViewCellViewModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieCollectionViewCellViewModelTests: XCTestCase {

    var sut: MovieCollectionViewCellViewModel!

    func test_VariablesAreCorrect_When_Initialized() {
        // Act
        sut = .init(movie: .stub(
            hasAdultContent: true,
            posterURL: URL(string: "www.example.com"),
            releaseDate: CTDateFormatter.shared.date(from: "2023-05-19", format: .yearMonthDayWithHyphens),
            title: "some title"
        ))

        // Assert
        XCTAssertEqual(sut.title, "some title")
        XCTAssertEqual(sut.releaseDate, "2023")
        XCTAssertEqual(sut.posterURL, URL(string: "www.example.com"))
        XCTAssertEqual(sut.title, "some title")
        XCTAssertFalse(sut.shouldHideAdultContentWarning)
    }
}
