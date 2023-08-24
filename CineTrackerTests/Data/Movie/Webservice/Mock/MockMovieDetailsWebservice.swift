//
//  MockMovieDetailsWebservice.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

class MockMovieDetailsWebservice: MovieDetailsWebservice {

    var invokedPerformRequest = false
    var invokedPerformRequestCount = 0
    var invokedPerformRequestParameters: (queryItems: [URLQueryItem]?, pathParameters: CVarArg)?
    var invokedPerformRequestParametersList = [(queryItems: [URLQueryItem]?, pathParameters: CVarArg)]()
    var stubbedPerformRequestResult: MovieDetails!
    var stubbedPerformRequestError: Swift.Error?

    override func performRequest(
        queryItems: [URLQueryItem]? = nil,
        pathParameters: CVarArg...
    ) async throws -> MovieDetails {
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
