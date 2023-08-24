//
//  UpcomingMoviesWebservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class UpcomingMoviesWebservice: Webservice<MovieList> {

    enum Parameters: String {
        case page
    }

    init(
        configuration: WebserviceConfiguration = CTWebserviceConfiguration(),
        client: HttpClient = .shared
    ) {
        super.init(
            endPoint: "3/movie/upcoming",
            configuration: configuration,
            client: client
        )
    }
}
