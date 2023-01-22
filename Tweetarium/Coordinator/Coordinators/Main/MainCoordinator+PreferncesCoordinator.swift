//
//  MainCoordinator+PreferencesCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation
import QuickSheet

extension MainCoordinator: PreferencesCoordinator {
    func reset() {
        self.parentCoordinator?.start()
    }
    
    func presetLogOutAlert() {
        let alert = factory.createLogOutAlert(coordinator: self)
        let options = QuickSheetOptions(fraction: 0.35, isExpandable: false, isScrollable: false, cornerRadius: 20)
        navigationController.presentQuickSheet(alert, options: options)
    }
}
