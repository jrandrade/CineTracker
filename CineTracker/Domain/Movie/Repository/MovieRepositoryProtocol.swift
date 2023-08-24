//
//  MovieRepositoryProtocol.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

protocol MovieRepositoryProtocol {

    func nowPlaying(page: Int) async throws -> CTMovieList
    func popular(page: Int) async throws -> CTMovieList
    func topRated(page: Int) async throws -> CTMovieList
    func upcoming(page: Int) async throws -> CTMovieList
    func details(forMovieId id: Int) async throws -> CTMovieDetails
}
