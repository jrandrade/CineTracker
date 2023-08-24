//
//  MovieDetailsViewController.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {

    private let scrollView: UIScrollView = UIScrollView()
    private let contentView = UIView()
    private let loadingView = LoadingView()
    private let errorView: ErrorView
    
    private var headerView: MovieDetailsHeaderView?
    private var descriptionLabel = UILabel()

    private let viewModel: MovieDetailsViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        errorView = .init(viewModel: viewModel.errorViewModel)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        viewModel.viewDidLoad()
    }
}

private extension MovieDetailsViewController {

    func configureView(withState state: MovieDetailsViewModel.State) {
        loadingView.isHidden = true
        contentView.isHidden = true
        errorView.isHidden = true

        switch state {
        case .loading:
            loadingView.isHidden = false
        case .error:
            errorView.isHidden = false
        case .success:
            configureContentStackView()
            title = viewModel.title
            contentView.isHidden = false
        }
    }

    func configureContentStackView() {
        if let headerView = viewModel.headerViewModel.map({
            MovieDetailsHeaderView(viewModel: $0)
        }) {
            contentView.addSubview(headerView)
            headerView.autoPinEdgesToSuperviewEdges([.leading, .top, .trailing])
            self.headerView = headerView

            descriptionLabel.text = viewModel.movieDescription
            
            contentView.addSubview(descriptionLabel)

            descriptionLabel.autoPinBelowView(headerView)
            descriptionLabel.autoPinEdgesToSuperviewEdges([.leading, .trailing, .bottom], withInset: 24)
        }
    }
}

extension MovieDetailsViewController: CanConfigureViews {

    func configureViewProperties() {
        view.backgroundColor = .surface

        descriptionLabel.text = viewModel.movieDescription
        descriptionLabel.font = .robotoMedium(size: 17)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
    }

    func configureViewEvents() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] state in
                self?.configureView(withState: state)
            }
            .store(in: &cancellables)
    }

    func configureViewHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(errorView)
        view.addSubview(loadingView)

        scrollView.addSubview(contentView)
    }

    func configureViewLayout() {
        scrollView.autoPinEdgesToSuperviewEdges()
        errorView.autoPinEdgesToSuperviewEdges()
        loadingView.autoPinEdgesToSuperviewEdges()

        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: scrollView)
    }
}
