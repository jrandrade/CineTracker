//
//  StubWebserviceConfiguration.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
@testable import CineTracker

struct StubWebserviceConfiguration: WebserviceConfiguration {
    var baseURL: String = ""
    var imageBaseUrl: String = ""
    var authenticationToken: String = ""
}
