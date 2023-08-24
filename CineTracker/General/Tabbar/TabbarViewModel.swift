//
//  TabbarViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

struct TabbarViewModel {

    let tabbarItemViewModels: [TabbarItemViewModel] = [
        .init(title: .localizedString(for: "topRated_title"), imageName: "topRated"),
        .init(title: .localizedString(for: "popular_title"), imageName: "popular"),
        .init(title: .localizedString(for: "nowPlaying_title"), imageName: "nowPlaying"),
        .init(title: .localizedString(for: "upcoming_title"), imageName: "upcoming")
    ]

    let popularViewModel = MovieCollectionViewModel(
        title: .localizedString(for: "popular_title"),
        getPaginatedMovieList: GetPopularMovies()
    )

    let topRatedViewModel = MovieCollectionViewModel(
        title: .localizedString(for: "topRated_title"),
        getPaginatedMovieList: GetTopRatedMovies()
    )

    let nowPlayingViewModel = MovieCollectionViewModel(
        title: .localizedString(for: "nowPlaying_title"),
        getPaginatedMovieList: GetNowPlayingMovies()
    )

    let upcomingViewModel = MovieCollectionViewModel(
        title: .localizedString(for: "upcoming_title"),
        getPaginatedMovieList: GetUpcomingMovies()
    )
}
