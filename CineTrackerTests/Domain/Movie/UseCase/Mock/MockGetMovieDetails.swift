//
//  MockGetMovieDetails.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 24/08/2023.
//

import Foundation
@testable import CineTracker

class MockGetMovieDetails: GetMovieDetails {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (movieId: Int, Void)?
    var invokedExecuteParametersList = [(movieId: Int, Void)]()
    var stubbedExecuteResult: CTMovieDetails!
    var stubbedExecuteError: Error?

    override func execute(movieId: Int) async throws -> CTMovieDetails {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (movieId, ())
        invokedExecuteParametersList.append((movieId, ()))

        if let stubbedExecuteError {
            throw stubbedExecuteError
        }

        return stubbedExecuteResult
    }
}
