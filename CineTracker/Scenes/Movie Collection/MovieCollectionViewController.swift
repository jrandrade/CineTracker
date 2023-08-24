//
//  MovieCollectionViewController.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit
import Combine

class MovieCollectionViewController: UICollectionViewController {

    private let loadingView = LoadingView()
    private let errorView: ErrorView

    private let cellIdentifier = String(describing: MovieCollectionViewCell.self)
    private let viewModel: MovieCollectionViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MovieCollectionViewModel) {
        self.viewModel = viewModel
        errorView = .init(viewModel: viewModel.errorViewModel)

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        super.init(collectionViewLayout: layout)
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

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? MovieCollectionViewCell
        else { return .init() }

        if let cellViewModel = viewModel.cellViewModels[safe: indexPath.row] {
            cell.configure(withViewModel: cellViewModel)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.item)?.navigate(using: self)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width / 3
        let cellHeight = cellWidth * 3/2

        return .init(width: cellWidth, height: cellHeight)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.shouldLoadMore(at: indexPath.row) {
            viewModel.loadMoreIfNeeded()
        }
    }
}

private extension MovieCollectionViewController {

    func configureView(withState state: MovieCollectionViewModel.State) {
        switch state {
        case .loading:
            collectionView.backgroundView = loadingView
        case .success:
            collectionView.backgroundView = nil
            collectionView.reloadData()
        case .error:
            collectionView.backgroundView = errorView
        default:
            break
        }
    }
}

extension MovieCollectionViewController: CanConfigureViews {

    func configureViewProperties() {
        title = viewModel.title

        collectionView.backgroundColor = .surface
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
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

	func configureViewHierarchy() {}

    func configureViewLayout() {}
}
