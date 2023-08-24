//
//  MovieCollectionViewCell.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let gradientImageView = UIImageView(image: .init(named: "verticalGradientBottom"))
    private let adultContentWarningView = AdultContentWarningView()
    private let releaseDateLabel = UILabel()
    private var viewModel: MovieCollectionViewCellViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withViewModel viewModel: MovieCollectionViewCellViewModel) {
        self.viewModel = viewModel
        configureViewProperties()
    }
}

extension MovieCollectionViewCell: CanConfigureViews {

    func configureViewProperties() {
        guard let viewModel else { return }

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.kf.setImage(with: viewModel.posterURL, options: [.transition(.fade(0.2))])
        posterImageView.clipsToBounds = true

        titleLabel.text = viewModel.title
        titleLabel.font = .robotoBold(size: 14)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0

        adultContentWarningView.isHidden = viewModel.shouldHideAdultContentWarning
        gradientImageView.contentMode = .scaleAspectFill

        releaseDateLabel.text = viewModel.releaseDate
        releaseDateLabel.font = .robotoRegular(size: 14)
        releaseDateLabel.textColor = .white
    }

	func configureViewHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(gradientImageView)
        contentView.addSubview(adultContentWarningView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
    }

    func configureViewLayout() {
        posterImageView.autoPinEdgesToSuperviewEdges()
        posterImageView.autoMatch(.height, to: .width, of: posterImageView, withMultiplier: 3/2)

        adultContentWarningView.autoPinEdgesToSuperviewEdges([.top, .trailing], withInset: 8)
        adultContentWarningView.autoSetDimensions(to: .square(44))

        gradientImageView.autoPinEdgesToSuperviewEdges([.leading, .trailing, .bottom])
        gradientImageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)

        titleLabel.autoPinEdge(.top, to: .top, of: gradientImageView, withOffset: 4)
        titleLabel.autoPinHorizontalEdgesToSuperViewEdges(withInset: 4)

        releaseDateLabel.autoPinBelowView(titleLabel, withOffset: 8)
        releaseDateLabel.autoPinHorizontalEdgesToSuperViewEdges(withInset: 4)
        releaseDateLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
    }
}
