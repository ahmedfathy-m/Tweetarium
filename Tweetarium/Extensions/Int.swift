//
//  Int.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/12/2022.
//

import Foundation

extension Int {
    var formattedInKFormat: String {
        if self > 999 {
            let kValue = Double(self) / Double(1000)
            return "\(String(format: "%0.1f", kValue))k"
        } else if self == 0 {
            return ""
        } else {
            return "\(self)"
        }
    }
}
