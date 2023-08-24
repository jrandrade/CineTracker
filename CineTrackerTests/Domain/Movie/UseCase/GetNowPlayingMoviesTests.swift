//
//  GetNowPlayingMoviesTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class GetNowPlayingMoviesTests: XCTestCase {

    var mockMovieRepository: MockMovieRepository!
    var sut: GetNowPlayingMovies!

    override func setUp() {
        super.setUp()
        mockMovieRepository = .init()
        sut = .init(repository: mockMovieRepository)
    }

    func test_RepositoryIsInvoked_When_CallingExecute() async throws {
        // Arrange
        mockMovieRepository.stubbedNowPlayingResult = CTMovieList.stub()

        // Act
        _ = try await sut.execute(page: 1)

        // Assert
        XCTAssert(mockMovieRepository.invokedNowPlaying)
        XCTAssertEqual(mockMovieRepository.invokedNowPlayingParameters?.page, 1)
    }

    func test_ReturnsCorrectMovieList_When_CallingExecute() async throws {
        // Arrange
        mockMovieRepository.stubbedNowPlayingResult = CTMovieList.stub(movies: [.stub(title: "some title")])

        // Act
        let result = try await sut.execute(page: 0)

        // Assert
        XCTAssertEqual(result.movies.count, 1)
        XCTAssertEqual(result.movies[0].title, "some title")
    }

    func test_ThrowsError_When_CallingExecute_Whilst_RepositoryThrowsError() async throws {
        // Arrange
        mockMovieRepository.stubbedNowPlayingError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.execute(page: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }
}
