//
//  WatchedMovie.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

struct WatchedMovie: Equatable {

    let id: Int
    let rate: Int

    init(ctWatchedMovie: CTWatchedMovie) {
        id = ctWatchedMovie.id
        rate = ctWatchedMovie.rate
    }
}

extension WatchedMovie {

    func toDomainModel() -> CTWatchedMovie {
        .init(id: id, rate: rate)
    }
}
