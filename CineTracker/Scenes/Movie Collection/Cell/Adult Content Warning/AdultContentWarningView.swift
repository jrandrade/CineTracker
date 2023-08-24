//
//  AdultContentWarningView.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit
import PureLayout

class AdultContentWarningView: UIView {

    private let textLabel = UILabel()
    private let viewModel: AdultContentWarningViewModel

    init(viewModel: AdultContentWarningViewModel = .init()) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

extension AdultContentWarningView: CanConfigureViews {

    func configureViewProperties() {
        layer.borderColor = UIColor.error?.cgColor
        layer.borderWidth = 5
        backgroundColor = .white

        textLabel.text = viewModel.text
        textLabel.font = .robotoBold(size: 14)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
    }

    func configureViewHierarchy() {
        addSubview(textLabel)
    }

    func configureViewLayout() {
        textLabel.autoPinEdgesToSuperviewEdges()
    }
}
