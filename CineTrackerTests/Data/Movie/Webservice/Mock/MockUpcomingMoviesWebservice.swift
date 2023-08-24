//
//  MockUpcomingMoviesWebservice.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

class MockUpcomingMoviesWebservice: UpcomingMoviesWebservice {

    var invokedPerformRequest = false
    var invokedPerformRequestCount = 0
    var invokedPerformRequestParameters: (queryItems: [URLQueryItem]?, pathParameters: CVarArg)?
    var invokedPerformRequestParametersList = [(queryItems: [URLQueryItem]?, pathParameters: CVarArg)]()
    var stubbedPerformRequestResult: MovieList!
    var stubbedPerformRequestError: Swift.Error?

    override func performRequest(
        queryItems: [URLQueryItem]? = nil,
        pathParameters: CVarArg...
    ) async throws -> MovieList {
        invokedPerformRequest = true
        invokedPerformRequestCount += 1
        invokedPerformRequestParameters = (queryItems, pathParameters)
        invokedPerformRequestParametersList.append((queryItems, pathParameters))

        if let stubbedPerformRequestError {
            throw stubbedPerformRequestError
        }

        return stubbedPerformRequestResult
    }
}
