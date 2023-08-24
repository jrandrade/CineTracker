//
//  MovieDetailsViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation
import Combine

class MovieDetailsViewModel {

    enum State {
        case loading
        case error
        case success
    }

    let errorViewModel = ErrorViewModel()

    @Published private(set) var state: State = .loading
    private(set) var headerViewModel: MovieDetailsHeaderViewModel?
    private(set) var title: String?
    private(set) var movieDescription: String?

    private let movieId: Int
    private let getMovieDetails: GetMovieDetails

    init(
        movieId: Int,
        getMovieDetails: GetMovieDetails = .init()
    ) {
        self.movieId = movieId
        self.getMovieDetails = getMovieDetails
    }

    func viewDidLoad() {
        loadDetails()
    }
}

private extension MovieDetailsViewModel {

    func loadDetails() {
        state = .loading

        Task {
            [weak self] in
            guard
                let movieId = self?.movieId,
                let details = try? await self?.getMovieDetails.execute(movieId: movieId)
            else {
                self?.state = .error
                return
            }

            self?.title = details.title
            self?.headerViewModel = .init(movieDetails: details)
            self?.movieDescription = details.overview

            self?.state = .success
        }
    }
}
