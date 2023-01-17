//
//  String+Localized.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation
postfix operator ~

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    mutating func localize() {
        let newLocalized = self.localized
        guard !newLocalized.isEmpty else { return }
        self = newLocalized
    }
    
    static postfix func ~ (string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
}
