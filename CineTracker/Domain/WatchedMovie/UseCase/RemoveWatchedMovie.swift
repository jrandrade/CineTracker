//
//  RemoveWatchedMovie.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

// Use case to save a watched movie
class RemoveWatchedMovie {

    private let repository: WatchedMoviesRepositoryProtocol

    init(repository: WatchedMoviesRepositoryProtocol = WatchedMovieRepository()) {
        self.repository = repository
    }

    func execute(movie: CTWatchedMovie) {
        repository.remove(movie)
    }
}
