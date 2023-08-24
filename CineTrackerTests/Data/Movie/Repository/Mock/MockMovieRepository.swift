//
//  MockMovieRepository.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

class MockMovieRepository: MovieRepository {

    var invokedNowPlaying = false
    var invokedNowPlayingCount = 0
    var invokedNowPlayingParameters: (page: Int, Void)?
    var invokedNowPlayingParametersList = [(page: Int, Void)]()
    var stubbedNowPlayingResult: CTMovieList!
    var stubbedNowPlayingError: Error?

    override func nowPlaying(page: Int) async throws -> CTMovieList {
        invokedNowPlaying = true
        invokedNowPlayingCount += 1
        invokedNowPlayingParameters = (page, ())
        invokedNowPlayingParametersList.append((page, ()))

        if let stubbedNowPlayingError {
            throw stubbedNowPlayingError
        }

        return stubbedNowPlayingResult
    }

    var invokedPopular = false
    var invokedPopularCount = 0
    var invokedPopularParameters: (page: Int, Void)?
    var invokedPopularParametersList = [(page: Int, Void)]()
    var stubbedPopularResult: CTMovieList!
    var stubbedPopularError: Error?

    override func popular(page: Int) async throws -> CTMovieList {
        invokedPopular = true
        invokedPopularCount += 1
        invokedPopularParameters = (page, ())
        invokedPopularParametersList.append((page, ()))

        if let stubbedPopularError {
            throw stubbedPopularError
        }

        return stubbedPopularResult
    }

    var invokedTopRated = false
    var invokedTopRatedCount = 0
    var invokedTopRatedParameters: (page: Int, Void)?
    var invokedTopRatedParametersList = [(page: Int, Void)]()
    var stubbedTopRatedResult: CTMovieList!
    var stubbedTopRatedError: Error?

    override func topRated(page: Int) async throws -> CTMovieList {
        invokedTopRated = true
        invokedTopRatedCount += 1
        invokedTopRatedParameters = (page, ())
        invokedTopRatedParametersList.append((page, ()))

        if let stubbedTopRatedError {
            throw stubbedTopRatedError
        }

        return stubbedTopRatedResult
    }

    var invokedUpcoming = false
    var invokedUpcomingCount = 0
    var invokedUpcomingParameters: (page: Int, Void)?
    var invokedUpcomingParametersList = [(page: Int, Void)]()
    var stubbedUpcomingResult: CTMovieList!
    var stubbedUpcomingError: Error?

    override func upcoming(page: Int) async throws -> CTMovieList {
        invokedUpcoming = true
        invokedUpcomingCount += 1
        invokedUpcomingParameters = (page, ())
        invokedUpcomingParametersList.append((page, ()))

        if let stubbedUpcomingError {
            throw stubbedUpcomingError
        }

        return stubbedUpcomingResult
    }

    var invokedDetails = false
    var invokedDetailsCount = 0
    var invokedDetailsParameters: (id: Int, Void)?
    var invokedDetailsParametersList = [(id: Int, Void)]()
    var stubbedDetailsResult: CTMovieDetails!
    var stubbedDetailsError: Error?

    override func details(forMovieId id: Int) async throws -> CTMovieDetails {
        invokedDetails = true
        invokedDetailsCount += 1
        invokedDetailsParameters = (id, ())
        invokedDetailsParametersList.append((id, ()))

        if let stubbedDetailsError {
            throw stubbedDetailsError
        }

        return stubbedDetailsResult
    }
}
