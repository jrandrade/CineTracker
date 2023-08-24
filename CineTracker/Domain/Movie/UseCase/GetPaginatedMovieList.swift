//
//  GetPaginatedMovieList.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

protocol GetPaginatedMovieList {
    func execute(page: Int) async throws -> CTMovieList
}
