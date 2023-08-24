//
//  PopularMoviesWebservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class PopularMoviesWebservice: Webservice<MovieList> {

    enum Parameters: String {
        case page
    }

    init(
        configuration: WebserviceConfiguration = CTWebserviceConfiguration(),
        client: HttpClient = .shared
    ) {
        super.init(
            endPoint: "3/movie/popular",
            configuration: configuration,
            client: client
        )
    }
}
