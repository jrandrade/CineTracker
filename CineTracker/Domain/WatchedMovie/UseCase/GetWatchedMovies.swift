//
//  GetWatchedMovies.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

// Use case to get all watched movies
class GetWatchedMovies {

    private let repository: WatchedMoviesRepositoryProtocol

    init(repository: WatchedMoviesRepositoryProtocol = WatchedMovieRepository()) {
        self.repository = repository
    }

    func execute() -> [CTWatchedMovie] {
        repository.watchedMovieList()
    }
}
