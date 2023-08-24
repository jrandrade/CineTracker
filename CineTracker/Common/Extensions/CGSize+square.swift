//
//  CGSize+square.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

extension CGSize {

    static func square(_ dimention: CGFloat) -> Self {
        .init(width: dimention, height: dimention)
    }
}
