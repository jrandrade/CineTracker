//
//  UITabbarItem+convenienceInit.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import UIKit

extension UITabBarItem {

    convenience init(viewModel: TabbarItemViewModel) {
        self.init(
            title: viewModel.title,
            image: .init(named: viewModel.imageName),
            selectedImage: .init(named: viewModel.imageName)
        )
    }
}
