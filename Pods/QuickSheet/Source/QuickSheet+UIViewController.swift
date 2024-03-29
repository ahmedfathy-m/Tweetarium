//
//  QuickSheet+UIViewController.swift
//  QuickSheets
//
//  Created by Ahmed Fathy on 07/01/2023.
//

import UIKit

extension UIViewController {
    public func presentQuickSheet(_ viewController: UIViewController, options: QuickSheetOptions) {
        let wrapper = QuickSheetWrapper()
        wrapper.childViewController = viewController
        wrapper.options = options
        wrapper.modalPresentationStyle = .custom
        self.present(wrapper, animated: false)
    }
}
