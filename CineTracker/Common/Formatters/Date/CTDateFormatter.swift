//
//  CTDateFormatter.swift
//  CineTracker
//
//  Created by Jorge Andrade on 21/08/2023.
//

import Foundation

class CTDateFormatter {

    static let shared = CTDateFormatter()

    private let dateFormatter = DateFormatter()

    private init() { }

    func date(from string: String, format: DateFormat) -> Date? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: string)
    }

    func string(from date: Date, format: DateFormat) -> String? {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
