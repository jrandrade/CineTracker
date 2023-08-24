//
//  GetMovieDetailsTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class GetMovieDetailsTests: XCTestCase {

    var mockMovieRepository: MockMovieRepository!
    var sut: GetMovieDetails!

    override func setUp() {
        super.setUp()
        mockMovieRepository = .init()
        sut = .init(repository: mockMovieRepository)
    }

    func test_RepositoryIsInvoked_When_CallingExecute() async throws {
        // Arrange
        mockMovieRepository.stubbedDetailsResult = CTMovieDetails.stub()

        // Act
        _ = try await sut.execute(movieId: 1)

        // Assert
        XCTAssert(mockMovieRepository.invokedDetails)
        XCTAssertEqual(mockMovieRepository.invokedDetailsParameters?.id, 1)
    }

    func test_ReturnsCorrectMovieList_When_CallingExecute() async throws {
        // Arrange
        mockMovieRepository.stubbedDetailsResult = CTMovieDetails.stub(title: "some title")

        // Act
        let result = try await sut.execute(movieId: 0)

        // Assert
        XCTAssertEqual(result.title, "some title")
    }

    func test_ThrowsError_When_CallingExecute_Whilst_RepositoryThrowsError() async throws {
        // Arrange
        mockMovieRepository.stubbedDetailsError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.execute(movieId: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }
}
