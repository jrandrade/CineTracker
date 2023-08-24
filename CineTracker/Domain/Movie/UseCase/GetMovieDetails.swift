//
//  GetMovieDetails.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

// Use case to get the details of a movie by it movieId

class GetMovieDetails {

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }

    func execute(movieId: Int) async throws -> CTMovieDetails {
        try await repository.details(forMovieId: movieId)
    }
}
