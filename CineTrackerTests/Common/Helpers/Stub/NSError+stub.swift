//
//  NSError+stub.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 23/08/2023.
//

import Foundation

extension NSError {

    static func stub(
        domain: String = "",
        code: Int = 0,
        userInfo: [String: Any]? = nil
    ) -> Self {
        .init(
            domain: domain,
            code: code,
            userInfo: userInfo
        )
    }
}
