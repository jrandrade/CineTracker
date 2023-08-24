//
//  NavigationController.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NavigationController {

    @objc func didTapBack() {
        popViewController(animated: true)
    }
}


extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()

        viewController.navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        
        if
            viewController.navigationItem.leftBarButtonItem == nil,
            viewControllers.count > 1
        {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: .init(systemName: "chevron.backward"),
                style: .plain,
                target: self,
                action: #selector(didTapBack)
            )
        }
    }
}

extension NavigationController: CanConfigureViews {

    func configureViewProperties() {
        delegate = self
        navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .surface

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.transformers(size: 21)
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.transformers(size: 51)
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .white
    }
}
