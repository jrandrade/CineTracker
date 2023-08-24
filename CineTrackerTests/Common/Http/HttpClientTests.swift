//
//  HttpClientTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import XCTest
@testable import CineTracker

class HttpClientTests: XCTestCase {

    var mockURLSession: MockURLSession!
    var sut: HttpClient!

    override func setUp() {
        super.setUp()
        mockURLSession = .init()
        sut = .init(urlSession: mockURLSession)
    }

    func test_URLSessionIsInvoked_When_CallingPerformGetRequest() async throws {
        // Arrange
        mockURLSession.stubbedDataResult = ("some text".data(using: .utf8)!, HTTPURLResponse())
        let json = """
        {
            "text": "some text"
        }
        """

        mockURLSession.stubbedDataResult = (json.data(using: .utf8)!, HTTPURLResponse())
        sut.authorizationToken = "some token"

        guard let url = URL(string: "www.example.com")
        else { return XCTFail("Expected URL")}

        // Act
        let _: TestHttpModel = try await sut.performGetRequest(for: url)

        // Assert
        XCTAssertEqual(mockURLSession.invokedDataParameters?.request.url, URL(string: "www.example.com"))

        XCTAssertEqual(
            mockURLSession.invokedDataParameters?.request.allHTTPHeaderFields?["Authorization"],
            "Bearer some token"
        )

        XCTAssertEqual(
            mockURLSession.invokedDataParameters?.request.allHTTPHeaderFields?["Content-Type"],
            "application/json;charset=utf-8"
        )
    }

    func test_ReturnsCorrectValue_When_CallingPerformGetRequest() async throws {
        // Arrange
        let json = """
        {
            "text": "some text"
        }
        """

        mockURLSession.stubbedDataResult = (json.data(using: .utf8)!, HTTPURLResponse())

        // Act
        guard let url = URL(string: "www.example.com")
        else { return XCTFail("Expected URL")}

        let result: TestHttpModel = try await sut.performGetRequest(for: url)

        // Assert
        XCTAssertEqual(result.text, "some text")
    }

    func test_ThrowsError_When_CallingPerformGetRequest_Whilst_URLSessionThrowsError() async throws {
        // Arrange
        mockURLSession.stubbedDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "some error"])

        // Act
        guard let url = URL(string: "www.example.com")
        else { return XCTFail("Expected URL")}

        do {
            let _: String = try await sut.performGetRequest(for: url)

            // Assert
            return XCTFail("Expected Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "some error")
        }
    }
}
