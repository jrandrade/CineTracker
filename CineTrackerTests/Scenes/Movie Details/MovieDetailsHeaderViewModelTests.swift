//
//  MovieDetailsHeaderViewModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 24/08/2023.
//

import XCTest
@testable import CineTracker

class MovieDetailsHeaderViewModelTests: XCTestCase {

    var sut: MovieDetailsHeaderViewModel!

    func test_VariablesAreCorrect_When_Initialized() {
        // Act
        sut = .init(movieDetails: .stub(
            backdropURL: URL(string: "www.backdrop.com"),
            budget: 10000,
            overview: "some overview",
            posterURL: URL(string: "www.poster.com"),
            releaseDate: CTDateFormatter.shared.date(from: "2023-08-10", format: .yearMonthDayWithHyphens),
            revenue: 5000000,
            runtime: 200,
            title: "some title"
        ))

        // Assert
        XCTAssertEqual(sut.backdropURL, URL(string: "www.backdrop.com"))
        XCTAssertEqual(sut.posterURL, URL(string: "www.poster.com"))

        XCTAssertEqual(sut.infoViewModels.count, 5)
        XCTAssertEqual(sut.infoViewModels[0].value, "some title")
        XCTAssertEqual(sut.infoViewModels[1].value, "10/08/2023")
        XCTAssertEqual(sut.infoViewModels[2].value, "200m")
        XCTAssertEqual(sut.infoViewModels[3].value, "10.000$")
        XCTAssertEqual(sut.infoViewModels[4].value, "5.000.000$")
    }
}
