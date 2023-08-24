//
//  HttpClient.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class HttpClient {

    static let shared = HttpClient()

    enum Error: Swift.Error {
        case unknown
        case noResponse
    }

    enum ContentType: String {
        case json = "application/json;charset=utf-8"
    }

    var authorizationToken: String?

    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession(configuration: .tcConfiguration())) {
        self.urlSession = urlSession
    }

    func performGetRequest<T: Decodable>(for url: URL, contentType: ContentType = .json) async throws -> T {
        let request = createGetRequest(url: url, contentType: contentType)
        let (data, urlResponse) = try await urlSession.data(for: request, delegate: nil)

        guard let response = urlResponse as? HTTPURLResponse
        else { throw Error.noResponse }

        switch response.statusCode {
        case 200..<300:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: data)
        default:
            throw Error.unknown
        }
    }
}

private extension HttpClient {

    func createGetRequest(url: URL, contentType: ContentType) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        if let authorizationToken {
            urlRequest.allHTTPHeaderFields = createHeaders(
                authorizationToken: authorizationToken,
                contentType: contentType
            )
        }

        return urlRequest
    }

    func createHeaders(authorizationToken: String, contentType: ContentType) -> [String: String] {
        [
            "Authorization": "Bearer \(authorizationToken)",
            "Content-Type": contentType.rawValue
        ]
    }
}
