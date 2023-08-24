//
//  MockGetPaginatedMovieList.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 24/08/2023.
//

import Foundation
@testable import CineTracker

class MockGetPaginatedMovieList: GetPaginatedMovieList {

    var invokedExecute = false
    var invokedExecuteCount = 0
    var invokedExecuteParameters: (page: Int, Void)?
    var invokedExecuteParametersList = [(page: Int, Void)]()
    var stubbedExecuteResult: CTMovieList!
    var stubbedExecuteError: Error?

    func execute(page: Int) async throws -> CTMovieList {
        invokedExecute = true
        invokedExecuteCount += 1
        invokedExecuteParameters = (page, ())
        invokedExecuteParametersList.append((page, ()))

        if let stubbedExecuteError {
            throw stubbedExecuteError
        }

        return stubbedExecuteResult
    }
}
