//
//  UIFont+Domain.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit

extension UIFont {

    static func transformers(size: CGFloat) -> UIFont {
        .init(
            name: "TransformersMovie",
            size: size
        ) ?? .systemFont(ofSize: size)
    }

    static func robotoBold(size: CGFloat) -> UIFont {
        .init(
            name: "Roboto-Bold",
            size: size
        ) ?? .systemFont(ofSize: size)
    }

    static func robotoMedium(size: CGFloat) -> UIFont {
        .init(
            name: "Roboto-Medium",
            size: size
        ) ?? .systemFont(ofSize: size)
    }

    static func robotoRegular(size: CGFloat) -> UIFont {
        .init(
            name: "Roboto-Regular",
            size: size
        ) ?? .systemFont(ofSize: size)
    }
}
