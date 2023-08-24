//
//  MovieDetails.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

struct MovieDetails: Decodable {

    let adult: Bool
    let backdropPath: String
    let budget: Int
    let homepage: String
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let title: String
}

extension MovieDetails {

    func toDomainModel(imageBaseURLString: String) -> CTMovieDetails {
        .init(
            hasAdultContent: adult,
            backdropURL: URL(string: imageBaseURLString + backdropPath),
            budget: budget,
            homepageURL: URL(string: homepage),
            id: id,
            overview: overview,
            posterURL: URL(string: imageBaseURLString + posterPath),
            releaseDate: CTDateFormatter.shared.date(from: releaseDate, format: .yearMonthDayWithHyphens),
            revenue: revenue,
            runtime: runtime,
            title: title
        )
    }
}
