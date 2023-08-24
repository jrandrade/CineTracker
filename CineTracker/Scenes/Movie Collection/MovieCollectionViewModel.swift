//
//  MovieCollectionViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Combine

class MovieCollectionViewModel {

    enum State {
        case loading
        case success
        case error
        case loadingMore
        case loadingMoreError
    }

    let title: String

    let errorViewModel = ErrorViewModel()

    @Published private(set) var state = State.loading

    private(set) var cellViewModels: [MovieCollectionViewCellViewModel] = []

    private let getPaginatedMovieList: GetPaginatedMovieList

    private var movies: [CTMovie] = []
    private var page = 1
    private var canLoadMore = false

    init(
        title: String,
        getPaginatedMovieList: GetPaginatedMovieList
    ) {
        self.title = title
        self.getPaginatedMovieList = getPaginatedMovieList
    }

    func viewDidLoad() {
        loadMovies()
    }

    func shouldLoadMore(at index: Int) -> Bool {
        index > cellViewModels.count - 10
    }

    func loadMoreIfNeeded() {
        guard canLoadMore else { return }

        page += 1
        loadMovies()
    }

    func didSelectItem(at index: Int) -> Navigator? {
        guard let movie = movies[safe: index] else { return nil }

        return MovieDetailsNavigator(viewModel: .init(movieId: movie.id))
    }
}

private extension MovieCollectionViewModel {

    func loadMovies() {
        Task {
            [weak self] in
            guard let self else { return }

            let isLoadingMore = page > 1

            state = isLoadingMore
            ? .loadingMore
            : .loading

            guard let movieList = try? await fetchMovieList(forPage: page) else {
                state = isLoadingMore
                ? .loadingMoreError
                : .error
                return
            }

            canLoadMore = movieList.totalPages > page

            movies.append(contentsOf: movieList.movies)

            cellViewModels = movies.map { .init(movie: $0) }

            state = .success
        }
    }

    func fetchMovieList(forPage page: Int) async throws -> CTMovieList {
        try await getPaginatedMovieList.execute(page: page)
    }
}
