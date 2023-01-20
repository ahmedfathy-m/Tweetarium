//
//  UILabel+Localized.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import UIKit

extension UIButton {
    @IBInspectable var localizedTitle: String? {
        get {
            return self.title(for: .normal)?.localized
        } set {
            self.setTitle(newValue?.localized, for: .normal)
        }
    }
}

extension UILabel {
    @IBInspectable var localizedTitle: String {
        get { (text ?? "")~ }
        set { text = newValue~ }
    }
}
