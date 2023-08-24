//
//  Collection+safeSubscript.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
