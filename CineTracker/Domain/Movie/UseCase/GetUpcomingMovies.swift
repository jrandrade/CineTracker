//
//  GetUpcomingMovies.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

// Usecase to get a paginated list of Upcoming Movies
class GetUpcomingMovies: GetPaginatedMovieList {

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> CTMovieList {
        try await repository.upcoming(page: page)
    }
}
