//
//  ErrorViewModel.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

struct ErrorViewModel {

    var onDidTapTryAgain: (() ->())?

    let imageName: String
    let title: String
    let message: String
    let tryAgainTitle = String.localizedString(for: "tryAgain")

    init(
        imageName: String = "error",
        title: String = .localizedString(for: "generic_error_title"),
        message: String = .localizedString(for: "generic_error_message")
    ) {
        self.imageName = imageName
        self.title = title
        self.message = message
    }
    func didTapTryAgain() {
        onDidTapTryAgain?()
    }
}
