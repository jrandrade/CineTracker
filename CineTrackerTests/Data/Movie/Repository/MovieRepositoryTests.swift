//
//  MovieRepositoryTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class MovieRepositoryTests: XCTestCase {

    var mockNowPlayingMoviesWebservice: MockNowPlayingMoviesWebservice!
    var mockPopularMoviesWebservice: MockPopularMoviesWebservice!
    var mockTopRatedMoviesWebservice: MockTopRatedMoviesWebservice!
    var mockUpcomingMoviesWebservice: MockUpcomingMoviesWebservice!
    var mockMovieDetailsWebservice: MockMovieDetailsWebservice!
    var sut: MovieRepository!

    override func setUp() {
        super.setUp()
        mockNowPlayingMoviesWebservice = .init()
        mockPopularMoviesWebservice = .init()
        mockTopRatedMoviesWebservice = .init()
        mockUpcomingMoviesWebservice = .init()
        mockMovieDetailsWebservice = .init()

        sut = .init(
            nowPlayingMoviesWebservice: mockNowPlayingMoviesWebservice,
            popularMoviesWebservice: mockPopularMoviesWebservice,
            topRatedMoviesWebservice: mockTopRatedMoviesWebservice,
            upcomingMoviesWebservice: mockUpcomingMoviesWebservice,
            movieDetailsWebservice: mockMovieDetailsWebservice
        )
    }

    // MARK: - NowPlaying -

    func test_NowPlayingMoviesWebserviceIsInvoked_When_CallingNowPlaying() async throws {
        // Arrange
        mockNowPlayingMoviesWebservice.stubbedPerformRequestResult = MovieList.stub()

        // Act
        _ = try await sut.nowPlaying(page: 1)

        // Assert
        XCTAssert(mockNowPlayingMoviesWebservice.invokedPerformRequest)
        XCTAssertEqual(mockNowPlayingMoviesWebservice.invokedPerformRequestParameters?.queryItems?.count, 1)
        XCTAssertEqual(mockNowPlayingMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].name, "page")
        XCTAssertEqual(mockNowPlayingMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].value, "1")
    }

    func test_ReturnsCorrectMovieList_When_CallingNowPlaying() async throws {
        // Arrange
        mockNowPlayingMoviesWebservice.stubbedPerformRequestResult = MovieList.stub(results: [.stub(title: "some title")])

        // Act
        let result = try await sut.nowPlaying(page: 0)

        // Assert
        XCTAssertEqual(result.movies.count, 1)
        XCTAssertEqual(result.movies[0].title, "some title")
    }

    func test_ThrowsError_When_CallingNowPlaying_Whilst_NowPlayingMoviesWebserviceThrowsError() async throws {
        // Arrange
        mockNowPlayingMoviesWebservice.stubbedPerformRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.nowPlaying(page: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }

    // MARK: - Popular -

    func test_PopularMoviesWebserviceIsInvoked_When_CallingPopular() async throws {
        // Arrange
        mockPopularMoviesWebservice.stubbedPerformRequestResult = MovieList.stub()

        // Act
        _ = try await sut.popular(page: 1)

        // Assert
        XCTAssert(mockPopularMoviesWebservice.invokedPerformRequest)
        XCTAssertEqual(mockPopularMoviesWebservice.invokedPerformRequestParameters?.queryItems?.count, 1)
        XCTAssertEqual(mockPopularMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].name, "page")
        XCTAssertEqual(mockPopularMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].value, "1")
    }

    func test_ReturnsCorrectMovieList_When_CallingPopular() async throws {
        // Arrange
        mockPopularMoviesWebservice.stubbedPerformRequestResult = MovieList.stub(results: [.stub(title: "some title")])

        // Act
        let result = try await sut.popular(page: 0)

        // Assert
        XCTAssertEqual(result.movies.count, 1)
        XCTAssertEqual(result.movies[0].title, "some title")
    }

    func test_ThrowsError_When_CallingPopular_Whilst_PopularMoviesWebserviceThrowsError() async throws {
        // Arrange
        mockPopularMoviesWebservice.stubbedPerformRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.popular(page: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }

    // MARK: - TopRated -

    func test_TopRatedMoviesWebserviceIsInvoked_When_CallingTopRated() async throws {
        // Arrange
        mockTopRatedMoviesWebservice.stubbedPerformRequestResult = MovieList.stub()

        // Act
        _ = try await sut.topRated(page: 1)

        // Assert
        XCTAssert(mockTopRatedMoviesWebservice.invokedPerformRequest)
        XCTAssertEqual(mockTopRatedMoviesWebservice.invokedPerformRequestParameters?.queryItems?.count, 1)
        XCTAssertEqual(mockTopRatedMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].name, "page")
        XCTAssertEqual(mockTopRatedMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].value, "1")
    }

    func test_ReturnsCorrectMovieList_When_CallingTopRated() async throws {
        // Arrange
        mockTopRatedMoviesWebservice.stubbedPerformRequestResult = MovieList.stub(results: [.stub(title: "some title")])

        // Act
        let result = try await sut.topRated(page: 0)

        // Assert
        XCTAssertEqual(result.movies.count, 1)
        XCTAssertEqual(result.movies[0].title, "some title")
    }

    func test_ThrowsError_When_CallingTopRated_Whilst_TopRatedMoviesWebserviceThrowsError() async throws {
        // Arrange
        mockTopRatedMoviesWebservice.stubbedPerformRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.topRated(page: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }

    // MARK: - Upcoming -

    func test_UpcomingMoviesWebserviceIsInvoked_When_CallingUpcoming() async throws {
        // Arrange
        mockUpcomingMoviesWebservice.stubbedPerformRequestResult = MovieList.stub()

        // Act
        _ = try await sut.upcoming(page: 1)

        // Assert
        XCTAssert(mockUpcomingMoviesWebservice.invokedPerformRequest)
        XCTAssertEqual(mockUpcomingMoviesWebservice.invokedPerformRequestParameters?.queryItems?.count, 1)
        XCTAssertEqual(mockUpcomingMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].name, "page")
        XCTAssertEqual(mockUpcomingMoviesWebservice.invokedPerformRequestParameters?.queryItems?[0].value, "1")
    }

    func test_ReturnsCorrectMovieList_When_CallingUpcoming() async throws {
        // Arrange
        mockUpcomingMoviesWebservice.stubbedPerformRequestResult = MovieList.stub(results: [.stub(title: "some title")])

        // Act
        let result = try await sut.upcoming(page: 0)

        // Assert
        XCTAssertEqual(result.movies.count, 1)
        XCTAssertEqual(result.movies[0].title, "some title")
    }

    func test_ThrowsError_When_CallingUpcoming_Whilst_UpcomingMoviesWebserviceThrowsError() async throws {
        // Arrange
        mockUpcomingMoviesWebservice.stubbedPerformRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.upcoming(page: 0)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }

    // MARK: - MovieDetais -

    func test_MovieDetailsWebserviceIsInvoked_When_CallingMovieDetails() async throws {
        // Arrange
        mockMovieDetailsWebservice.stubbedPerformRequestResult = MovieDetails.stub()

        // Act
        _ = try await sut.details(forMovieId: 1)

        // Assert
        XCTAssert(mockMovieDetailsWebservice.invokedPerformRequest)
    }

    func test_ReturnsCorrectMovieList_When_CallingMovieDetails() async throws {
        // Arrange
        mockMovieDetailsWebservice.stubbedPerformRequestResult = MovieDetails.stub(title: "some title")

        // Act
        let result = try await sut.details(forMovieId: 1)

        // Assert
        XCTAssertEqual(result.title, "some title")
    }

    func test_ThrowsError_When_CallingMovieDetails_Whilst_MovieDetailsWebserviceThrowsError() async throws {
        // Arrange
        mockMovieDetailsWebservice.stubbedPerformRequestError = NSError.stub(userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        do {
            _ = try await sut.details(forMovieId: 1)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }
}
