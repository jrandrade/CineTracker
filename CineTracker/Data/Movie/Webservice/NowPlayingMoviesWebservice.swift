//
//  NowPlayingMoviesWebservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class NowPlayingMoviesWebservice: Webservice<MovieList> {

    enum Parameters: String {
        case page
    }

    init(
        configuration: WebserviceConfiguration = CTWebserviceConfiguration(),
        client: HttpClient = .shared
    ) {
        super.init(
            endPoint: "3/movie/now_playing",
            configuration: configuration,
            client: client
        )
    }
}
