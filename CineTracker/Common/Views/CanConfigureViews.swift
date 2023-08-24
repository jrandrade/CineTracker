//
//  CanConfigureViews.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import Foundation

protocol CanConfigureViews {
    func configureViews()
    func configureViewProperties()
    func configureViewEvents()
    func configureViewHierarchy()
    func configureViewLayout()
}

extension CanConfigureViews {

    func configureViews() {
        configureViewProperties()
        configureViewEvents()
        configureViewHierarchy()
        configureViewLayout()
    }

    func configureViewProperties() {}
    func configureViewEvents() {}
    func configureViewHierarchy() {}
    func configureViewLayout() {}
}
