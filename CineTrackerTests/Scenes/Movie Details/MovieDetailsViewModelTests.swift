//
//  MovieDetailsViewModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 24/08/2023.
//

import XCTest
@testable import CineTracker

class MovieDetailsViewModelTests: XCTestCase {

    var mockGetMovieDetails: MockGetMovieDetails!
    var sut: MovieDetailsViewModel!

    override func setUp() {
        super.setUp()
        mockGetMovieDetails = .init()
        sut = MovieDetailsViewModel(movieId: 1, getMovieDetails: mockGetMovieDetails)
    }

    // MARK: - ViewDidLoad -

    func test_GetPaginatedMovieListIsInvoked_When_CallingViewDidLoad() {
        // Arrange
        mockGetMovieDetails.stubbedExecuteResult = .stub()

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .dropFirst(2)
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssert(mockGetMovieDetails.invokedExecute)
        XCTAssertEqual(mockGetMovieDetails.invokedExecuteParameters?.movieId, 1)
    }

    func test_CellViewModelsAreCorrect_When_CallingViewDidLoad() {
        // Arrange
        mockGetMovieDetails.stubbedExecuteResult = .stub(backdropURL: URL(string: "www.example.com"), overview: "some overview")

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(sut.headerViewModel?.backdropURL, URL(string: "www.example.com"))
        XCTAssertEqual(sut.movieDescription, "some overview")
    }

    func test_EmitsStateSuccess_When_CallingViewDidLoad() {
        // Arrange
        mockGetMovieDetails.stubbedExecuteResult = .stub()
        var emmitedState: MovieDetailsViewModel.State?

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                state in
                emmitedState = state
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .success)
    }

    func test_EmitsStateError_When_CallingViewDidLoad_Whislt_GetPaginatedMovieListThrowsError() {
        // Arrange
        mockGetMovieDetails.stubbedExecuteError = NSError.stub()
        var emmitedState: MovieDetailsViewModel.State?

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                state in
                emmitedState = state
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .error)
    }
}
