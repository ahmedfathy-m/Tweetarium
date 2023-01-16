//
//  RootTabbarController+.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import Foundation

extension RootTabbarController: TwitterHeaderDelegate {
    func didRequestPresentationOfPreferences() {
        coordinator?.shouldNavigateToSettings()
    }
}
