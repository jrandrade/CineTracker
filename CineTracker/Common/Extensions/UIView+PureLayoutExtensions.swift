//
//  UIView+PureLayoutExtensions.swift
//  CineTracker
//
//  Created by Jorge Andrade on 22/08/2023.
//

import UIKit
import PureLayout

extension UIView {

    @discardableResult func autoPinEdgesToSuperviewEdges(
        _ edges: [ALEdge],
        withInset inset: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        edges.map { autoPinEdge(toSuperviewEdge: $0, withInset: inset) }
    }

    @discardableResult func autoPinHorizontalEdgesToSuperViewEdges(withInset inset: CGFloat = 0) -> [NSLayoutConstraint] {
        [
            autoPinEdge(toSuperviewEdge: .leading, withInset: inset),
            autoPinEdge(toSuperviewEdge: .trailing, withInset: inset)
        ]
    }

    @discardableResult func autoPinVerticalEdgesToSuperViewEdges(withInset inset: CGFloat = 0) -> [NSLayoutConstraint] {
        [
            autoPinEdge(toSuperviewEdge: .top, withInset: inset),
            autoPinEdge(toSuperviewEdge: .bottom, withInset: inset)
        ]
    }

    @discardableResult func autoPinBelowView(_ view: UIView, withOffset offset: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        autoPinEdge(.top, to: .bottom, of: view, withOffset: offset, relation: relation)
    }
}
