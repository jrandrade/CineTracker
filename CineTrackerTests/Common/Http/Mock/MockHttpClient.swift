//
//  MockHttpClient.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

class MockHttpClient: HttpClient {

    var invokedAuthorizationTokenSetter = false
    var invokedAuthorizationTokenSetterCount = 0
    var invokedAuthorizationToken: String?
    var invokedAuthorizationTokenList = [String?]()
    var invokedAuthorizationTokenGetter = false
    var invokedAuthorizationTokenGetterCount = 0
    var stubbedAuthorizationToken: String!

    override var authorizationToken: String? {
        set {
            invokedAuthorizationTokenSetter = true
            invokedAuthorizationTokenSetterCount += 1
            invokedAuthorizationToken = newValue
            invokedAuthorizationTokenList.append(newValue)
        }
        get {
            invokedAuthorizationTokenGetter = true
            invokedAuthorizationTokenGetterCount += 1
            return stubbedAuthorizationToken
        }
    }

    var invokedPerformGetRequest = false
    var invokedPerformGetRequestCount = 0
    var invokedPerformGetRequestParameters: (url: URL, contentType: ContentType)?
    var invokedPerformGetRequestParametersList = [(url: URL, contentType: ContentType)]()
    var stubbedPerformGetRequestResult: Decodable!
    var stubbedPerformGetRequestError: Swift.Error!

    override func performGetRequest<T: Decodable>(for url: URL, contentType: ContentType = .json) async throws -> T {
        invokedPerformGetRequest = true
        invokedPerformGetRequestCount += 1
        invokedPerformGetRequestParameters = (url, contentType)
        invokedPerformGetRequestParametersList.append((url, contentType))

        if let stubbedPerformGetRequestError {
            throw stubbedPerformGetRequestError
        }

        return stubbedPerformGetRequestResult as! T
    }
}
