//
//  WatchedMovieRepository.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

class WatchedMovieRepository: UserDefaultRepository<WatchedMovie>, WatchedMoviesRepositoryProtocol {

    init() {
        super.init(key: "watchedMovie")
    }

    func watchedMovieList() -> [CTWatchedMovie] {
        getAll().map { $0.toDomainModel() }
    }

    func add(_ movie: CTWatchedMovie) {
        add(object: .init(ctWatchedMovie: movie))
    }

    func remove(_ movie: CTWatchedMovie) {
        remove(object: .init(ctWatchedMovie: movie))
    }
}
