//
//  TopRatedMoviesWebservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class TopRatedMoviesWebservice: Webservice<MovieList> {

    enum Parameters: String {
        case page
    }

    init(
        configuration: WebserviceConfiguration = CTWebserviceConfiguration(),
        client: HttpClient = .shared
    ) {
        super.init(
            endPoint: "3/movie/top_rated",
            configuration: configuration,
            client: client
        )
    }
}
