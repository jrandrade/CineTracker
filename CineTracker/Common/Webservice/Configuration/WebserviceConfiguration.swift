//
//  WebserviceConfiguration.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

protocol WebserviceConfiguration {
    var baseURL: String { get }
    var imageBaseUrl: String { get }
    var authenticationToken: String { get }
}
