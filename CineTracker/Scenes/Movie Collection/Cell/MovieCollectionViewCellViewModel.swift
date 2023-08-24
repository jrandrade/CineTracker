//
//  MovieCollectionViewCellViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

class MovieCollectionViewCellViewModel {

    let posterURL: URL?
    let title: String
    let releaseDate: String?
    let shouldHideAdultContentWarning: Bool

    init(
        movie: CTMovie
    ) {
        posterURL = movie.posterURL
        title = movie.title
        shouldHideAdultContentWarning = !movie.hasAdultContent

        releaseDate = movie.releaseDate.flatMap {
            CTDateFormatter.shared.string(from: $0, format: .year)
        }
    }
}
