//
//  ErrorView.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit

class ErrorView: UIView {

    private let containerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let tryAgainButton = UIButton()

    private let viewModel: ErrorViewModel

    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {

    func didTapTryAgain() {
        viewModel.didTapTryAgain()
    }
}

extension ErrorView: CanConfigureViews {

    func configureViewProperties() {
        backgroundColor = .clear
        
        imageView.image = .init(named: viewModel.imageName)

        titleLabel.text = viewModel.title
        titleLabel.font = .robotoBold(size: 17)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        messageLabel.text = viewModel.message
        messageLabel.font = .robotoRegular(size: 14)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center

        tryAgainButton.setTitle(viewModel.tryAgainTitle, for: .normal)
        tryAgainButton.tintColor = .white
        tryAgainButton.titleLabel?.font = .robotoMedium(size: 14)
        tryAgainButton.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        tryAgainButton.layer.cornerRadius = 8
    }

	func configureViewHierarchy() {
        addSubview(containerView)

        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(tryAgainButton)
    }

    func configureViewLayout() {
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24, relation: .greaterThanOrEqual)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24, relation: .greaterThanOrEqual)
        containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 32, relation: .greaterThanOrEqual)
        containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32, relation: .greaterThanOrEqual)
        containerView.autoCenterInSuperview()

        imageView.autoPinEdge(toSuperviewEdge: .top)
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoSetDimensions(to: .square(200))

        titleLabel.autoPinBelowView(imageView, withOffset: 24)
        titleLabel.autoPinHorizontalEdgesToSuperViewEdges()

        messageLabel.autoPinBelowView(titleLabel, withOffset: 8)
        messageLabel.autoPinHorizontalEdgesToSuperViewEdges()

        tryAgainButton.autoPinBelowView(messageLabel, withOffset: 8)
        tryAgainButton.autoAlignAxis(toSuperviewAxis: .vertical)
        tryAgainButton.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
