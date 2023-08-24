//
//  MovieRepository.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {

    private let webserviceConfiguration: WebserviceConfiguration
    private let nowPlayingMoviesWebservice: NowPlayingMoviesWebservice
    private let popularMoviesWebservice: PopularMoviesWebservice
    private let topRatedMoviesWebservice: TopRatedMoviesWebservice
    private let upcomingMoviesWebservice: UpcomingMoviesWebservice
    private let movieDetailsWebservice: MovieDetailsWebservice

    init(
        webserviceConfiguration: WebserviceConfiguration = CTWebserviceConfiguration(),
        nowPlayingMoviesWebservice: NowPlayingMoviesWebservice = .init(),
        popularMoviesWebservice: PopularMoviesWebservice = .init(),
        topRatedMoviesWebservice: TopRatedMoviesWebservice = .init(),
        upcomingMoviesWebservice: UpcomingMoviesWebservice = .init(),
        movieDetailsWebservice: MovieDetailsWebservice = .init()
    ) {
        self.webserviceConfiguration = webserviceConfiguration
        self.nowPlayingMoviesWebservice = nowPlayingMoviesWebservice
        self.popularMoviesWebservice = popularMoviesWebservice
        self.topRatedMoviesWebservice = topRatedMoviesWebservice
        self.upcomingMoviesWebservice = upcomingMoviesWebservice
        self.movieDetailsWebservice = movieDetailsWebservice
    }

    func nowPlaying(page: Int) async throws -> CTMovieList {
        let pageQueryItemName = NowPlayingMoviesWebservice.Parameters.page.rawValue
        let pageQueryItem = URLQueryItem(name: pageQueryItemName, value: "\(page)")

        let results = try await nowPlayingMoviesWebservice.performRequest(queryItems: [pageQueryItem])

        return results.toDomainModel(imageBaseURLString: webserviceConfiguration.imageBaseUrl)
    }

    func popular(page: Int) async throws -> CTMovieList {
        let pageQueryItemName = PopularMoviesWebservice.Parameters.page.rawValue
        let pageQueryItem = URLQueryItem(name: pageQueryItemName, value: "\(page)")

        let results = try await popularMoviesWebservice.performRequest(queryItems: [pageQueryItem])

        return results.toDomainModel(imageBaseURLString: webserviceConfiguration.imageBaseUrl)
    }

    func topRated(page: Int) async throws -> CTMovieList {
        let pageQueryItemName = TopRatedMoviesWebservice.Parameters.page.rawValue
        let pageQueryItem = URLQueryItem(name: pageQueryItemName, value: "\(page)")

        let results = try await topRatedMoviesWebservice.performRequest(queryItems: [pageQueryItem])

        return results.toDomainModel(imageBaseURLString: webserviceConfiguration.imageBaseUrl)
    }

    func upcoming(page: Int) async throws -> CTMovieList {
        let pageQueryItemName = UpcomingMoviesWebservice.Parameters.page.rawValue
        let pageQueryItem = URLQueryItem(name: pageQueryItemName, value: "\(page)")

        let results = try await upcomingMoviesWebservice.performRequest(queryItems: [pageQueryItem])

        return results.toDomainModel(imageBaseURLString: webserviceConfiguration.imageBaseUrl)
    }

    func details(forMovieId id: Int) async throws -> CTMovieDetails {
        let results = try await movieDetailsWebservice.performRequest(pathParameters: id)

        return results.toDomainModel(imageBaseURLString: webserviceConfiguration.imageBaseUrl)
    }
}
