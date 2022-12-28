//
//  String.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation
import UIKit

extension String {
    func percentEncoded() -> Self {
        let charSet = CharacterSet(charactersIn: "01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0-._~")
        return self.addingPercentEncoding(withAllowedCharacters: charSet)!
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        if bounds.upperBound > self.count - 1 {
            let last = index(startIndex, offsetBy: self.count - 1)
            return String(self[start...last])
        } else {
            let end = index(startIndex, offsetBy: bounds.upperBound)
            return String(self[start...end])
        }
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        if bounds.upperBound > self.count {
            let last = index(startIndex, offsetBy: self.count - 1)
            return String(self[start..<last])
        } else {
            let end = index(startIndex, offsetBy: bounds.upperBound)
            return String(self[start..<end])
        }
    }
}

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.link: linkURL,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]
            self.setAttributes(attributes, range: foundRange)
        }
    }
}
