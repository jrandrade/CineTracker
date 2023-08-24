//
//  LocalizedString.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

extension String {

    static func localizedString(for key: String) -> String {
        NSLocalizedString(key, comment: key)
    }
}
