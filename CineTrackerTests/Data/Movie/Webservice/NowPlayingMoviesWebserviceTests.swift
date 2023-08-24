//
//  NowPlayingMoviesWebserviceTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class NowPlayingMoviesWebserviceTests: XCTestCase {

    var stubConfiguration: StubWebserviceConfiguration!
    var mockHttpClient: MockHttpClient!
    var sut: NowPlayingMoviesWebservice!

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
        mockHttpClient.stubbedPerformGetRequestResult = MovieList.stub()

        // Act
        _ = try await sut.performRequest()

        // Assert
        XCTAssert(mockHttpClient.invokedPerformGetRequest)
        XCTAssertEqual(mockHttpClient.invokedPerformGetRequestParameters?.url, URL(string: "www.example.com/3/movie/now_playing"))
    }

    func test_ReturnsCorrectMovieList_When_CallingPerformRequest() async throws {
        // Arrange
        mockHttpClient.stubbedPerformGetRequestResult = MovieList.stub(results: [.stub(title: "some title")])

        // Act
        let result = try await sut.performRequest()

        // Assert
        XCTAssertEqual(result.results.count, 1)
        XCTAssertEqual(result.results[0].title, "some title")
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
