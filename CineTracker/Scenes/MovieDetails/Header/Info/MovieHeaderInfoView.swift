//
//  MovieHeaderInfoView.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit

class MovieHeaderInfoView: UIView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    private let viewModel: MovieHeaderInfoViewModel

    init(viewModel: MovieHeaderInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect())
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieHeaderInfoView: CanConfigureViews {

    func configureViewProperties() {
        titleLabel.text = viewModel.title
        titleLabel.font = .robotoBold(size: 17)
        titleLabel.textColor = .white

        valueLabel.text = viewModel.value
        valueLabel.font = .robotoRegular(size: 17)
        valueLabel.textColor = .white
        valueLabel.numberOfLines = 0
    }

    func configureViewHierarchy() {
        addSubview(titleLabel)
        addSubview(valueLabel)
    }

    func configureViewLayout() {
        titleLabel.autoPinEdgesToSuperviewEdges([.leading, .top])
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0, relation: .greaterThanOrEqual)

        valueLabel.autoPinEdge(.leading, to: .trailing, of: titleLabel, withOffset: 8)
        valueLabel.autoPinEdgesToSuperviewEdges([.top, .trailing, .bottom])
    }
}
