//
//  MovieDetailsWebservice.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

class MovieDetailsWebservice: Webservice<MovieDetails> {

    init(
        configuration: WebserviceConfiguration = CTWebserviceConfiguration(),
        client: HttpClient = .shared
    ) {
        super.init(
            endPoint: "3/movie/%d",
            configuration: configuration,
            client: client
        )
    }
}
