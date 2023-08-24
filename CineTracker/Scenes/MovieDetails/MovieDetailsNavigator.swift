//
//  MovieDetailsNavigator.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit

struct MovieDetailsNavigator: Navigator {

    let viewModel: MovieDetailsViewModel

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }

    func navigate(using owner: UIViewController?) {
        owner?.navigationController?.pushViewController(
            MovieDetailsViewController(viewModel: viewModel),
            animated: true
        )
    }
}
