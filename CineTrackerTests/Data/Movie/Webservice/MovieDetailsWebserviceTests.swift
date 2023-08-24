//
//  MovieDetailsWebserviceTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieDetailsWebserviceTests: XCTestCase {

    var stubConfiguration: StubWebserviceConfiguration!
    var mockHttpClient: MockHttpClient!
    var sut: MovieDetailsWebservice!

    override func setUp() {
        super.setUp()
        stubConfiguration = .init()
        mockHttpClient = .init()

        stubConfiguration.baseURL = "www.example.com/"

        sut = .init(
            configuration: stubConfiguration,
            client: mockHttpClient
        )
    }

    func test_HttpClientIsInvoked_When_CallingPerformRequest() async throws {
        // Arrange
        mockHttpClient.stubbedPerformGetRequestResult = MovieDetails.stub()

        // Act
        _ = try await sut.performRequest(pathParameters: 130)

        // Assert
        XCTAssert(mockHttpClient.invokedPerformGetRequest)
        XCTAssertEqual(mockHttpClient.invokedPerformGetRequestParameters?.url, URL(string: "www.example.com/3/movie/130"))
    }

    func test_ReturnsCorrectMovieList_When_CallingPerformRequest() async throws {
        // Arrange
        mockHttpClient.stubbedPerformGetRequestResult = MovieDetails.stub(title: "some title")

        // Act
        let result = try await sut.performRequest()

        // Assert
        XCTAssertEqual(result.title, "some title")
    }

    func test_ThrowsError_When_CallingPerformRequest_Whilst_HttpClientThrowsError() async throws {
        // Arrange
        mockHttpClient.stubbedPerformGetRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.performRequest()

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }
}
