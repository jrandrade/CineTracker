//
//  WatchedMoviesRepositoryProtocol.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

protocol WatchedMoviesRepositoryProtocol {

    func watchedMovieList() -> [CTWatchedMovie]
    func add(_ movie: CTWatchedMovie)
    func remove(_ movie: CTWatchedMovie)
}
