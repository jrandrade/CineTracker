//
//  TabbarController.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit

class TabbarController: UITabBarController {

    private let viewModel: TabbarViewModel

    init(viewModel: TabbarViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}

// MARK: - ViewControllers -

private extension TabbarController {

    func configureViewControllers() {
        let viewControllers = [
            NavigationController(rootViewController: MovieCollectionViewController(viewModel: viewModel.topRatedViewModel)),
            NavigationController(rootViewController: MovieCollectionViewController(viewModel: viewModel.popularViewModel)),
            NavigationController(rootViewController: MovieCollectionViewController(viewModel: viewModel.nowPlayingViewModel)),
            NavigationController(rootViewController: MovieCollectionViewController(viewModel: viewModel.upcomingViewModel))
        ]

        viewControllers.enumerated().forEach {
            index, viewController in
            guard let tabBarItemViewModel = viewModel.tabbarItemViewModels[safe: index]
            else { return }

            viewController.tabBarItem = .init(viewModel: tabBarItemViewModel)
        }

        self.viewControllers = viewControllers
    }
}

// MARK: - CanConfigureViews -

extension TabbarController: CanConfigureViews {

    func configureViewProperties() {
        configureViewControllers()
        selectedIndex = 2

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .surface

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
    }
}
