//
//  Webservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class Webservice<T: Decodable> {

    enum Error: Swift.Error {
        case invalidURL
    }

    private let endPoint: String
    private let configuration: WebserviceConfiguration
    private let client: HttpClient

    init(
        endPoint: String,
        configuration: WebserviceConfiguration,
        client: HttpClient
    ) {
        self.endPoint = endPoint
        self.configuration = configuration
        self.client = client
    }

    func performRequest(
        queryItems: [URLQueryItem]? = nil,
        pathParameters: CVarArg...
    ) async throws -> T {
        guard var urlComponents = URLComponents(string: configuration.baseURL)
        else { throw Error.invalidURL }

        urlComponents.path += String(format: endPoint, pathParameters)
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { throw Error.invalidURL }

        return try await client.performGetRequest(for: url)
    }
}
