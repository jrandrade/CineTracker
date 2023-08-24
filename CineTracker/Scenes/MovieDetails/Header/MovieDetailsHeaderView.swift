//
//  MovieDetailsHeaderView.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit
import Kingfisher

class MovieDetailsHeaderView: UIView {

    private let backdropImageView = UIImageView()
    private let posterImageView = UIImageView()
    private let stackView = UIStackView()

    private let viewModel: MovieDetailsHeaderViewModel

    init(viewModel: MovieDetailsHeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailsHeaderView: CanConfigureViews {

    func configureViewProperties() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.kf.setImage(with: viewModel.backdropURL, options: [.transition(.fade(0.2))])

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.kf.setImage(with: viewModel.posterURL, options: [.transition(.fade(0.2))])

        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
    }

	func configureViewHierarchy() {
        addSubview(backdropImageView)
        addSubview(posterImageView)
        addSubview(stackView)

        viewModel.infoViewModels.forEach {
            stackView.addArrangedSubview(MovieHeaderInfoView(viewModel: $0))
        }
    }

    func configureViewLayout() {
        backdropImageView.autoPinEdgesToSuperviewEdges([.leading, .top, .trailing])
        backdropImageView.autoMatch(.height, to: .width, of: backdropImageView, withMultiplier: 9/16)

        posterImageView.autoPinBelowView(backdropImageView, withOffset: 16)
        posterImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        posterImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        posterImageView.autoSetDimension(.width, toSize: 100)
        posterImageView.autoMatch(.height, to: .width, of: posterImageView, withMultiplier: 3/2)

        stackView.autoPinEdge(.leading, to: .trailing, of: posterImageView, withOffset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        stackView.autoAlignAxis(.horizontal, toSameAxisOf: posterImageView)
    }
}
