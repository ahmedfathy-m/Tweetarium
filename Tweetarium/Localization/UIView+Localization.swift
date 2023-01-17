//
//  UIView+Localization.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation
import UIKit

extension UIView {
    static func updateViewsDirection() {
        if UserDefaults.standard.currentLanguage == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else if UserDefaults.standard.currentLanguage == "en" {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}
