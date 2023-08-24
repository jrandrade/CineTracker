//
//  CTNumberFormatter.swift
//  CineTracker
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

class CTNumberFormatter {

    static let shared = CTNumberFormatter()

    let numberFormatter = NumberFormatter()

    private init() {
        numberFormatter.groupingSize = 3
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.groupingSeparator = "."
    }

    func format(number: NSNumber) -> String? {
        numberFormatter.string(from: number)
    }
}
