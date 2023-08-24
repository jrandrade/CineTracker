//
//  MockURLSession.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

class MockURLSession: URLSessionProtocol {

    var invokedData = false
    var invokedDataCount = 0
    var invokedDataParameters: (request: URLRequest, delegate: (URLSessionTaskDelegate)?)?
    var invokedDataParametersList = [(request: URLRequest, delegate: (URLSessionTaskDelegate)?)]()
    var stubbedDataResult: (Data, URLResponse)!
    var stubbedDataError: Error?

    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        invokedData = true
        invokedDataCount += 1
        invokedDataParameters = (request, delegate)
        invokedDataParametersList.append((request, delegate))

        if let stubbedDataError {
            throw stubbedDataError
        }

        return stubbedDataResult
    }
}
