//
//  MovieDetailsHeaderViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

struct MovieDetailsHeaderViewModel {

    let backdropURL: URL?
    let posterURL: URL?
    let infoViewModels: [MovieHeaderInfoViewModel]

    init(
        movieDetails: CTMovieDetails
    ) {
        backdropURL = movieDetails.backdropURL
        posterURL = movieDetails.posterURL

        let releaseInfo: MovieHeaderInfoViewModel? = movieDetails.releaseDate.flatMap {
            guard let value = CTDateFormatter.shared.string(from: $0, format: .dayMonthYearWithSlashes)
            else { return nil }

            return MovieHeaderInfoViewModel(
                title: .localizedString(for: "details_releaseDate_title"),
                value: value
            )
        }

        let budget = CTNumberFormatter.shared.format(number: NSNumber(integerLiteral: movieDetails.budget))
        let revenue = CTNumberFormatter.shared.format(number: NSNumber(integerLiteral: movieDetails.revenue))

        infoViewModels = [
            .init(
                title: .localizedString(for: "details_movieTitle_title"),
                value: movieDetails.title
            ),
            releaseInfo,
            .init(
                title: .localizedString(for: "details_runtime_title"),
                value: "\(movieDetails.runtime)m"
            ),
            budget.map {
                .init(
                    title: .localizedString(for: "details_budget_title"),
                    value: "\($0)$"
                )
            },
            revenue.map {
                .init(
                    title: .localizedString(for: "details_revenue_title"),
                    value: "\($0)$"
                )
            }
        ].compactMap { $0 }
    }
}
