//
//  LoadingView.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit

class LoadingView: UIView {

    private let containerView = UIView()
    private let imageView = UIImageView()
    private let spinner = UIActivityIndicatorView(style: .large)

    private let viewModel: LoadingViewModel

    init(viewModel: LoadingViewModel = .init()) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: CanConfigureViews {

    func configureViewProperties() {
        backgroundColor = .clear
        imageView.image = .init(named: viewModel.imageName)

        spinner.color = .white
        spinner.startAnimating()
    }

    func configureViewHierarchy() {
        addSubview(containerView)

        containerView.addSubview(imageView)
        containerView.addSubview(spinner)
    }

    func configureViewLayout() {
        containerView.autoCenterInSuperview()

        imageView.autoPinEdgesToSuperviewEdges([.leading, .top, .trailing])
        imageView.autoSetDimensions(to: .square(200))

        spinner.autoPinBelowView(imageView, withOffset: 16)
        spinner.autoAlignAxis(toSuperviewAxis: .vertical)
        spinner.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
