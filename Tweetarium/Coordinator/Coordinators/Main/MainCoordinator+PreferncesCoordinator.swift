//
//  MainCoordinator+PreferencesCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation

extension MainCoordinator: PreferencesCoordinator {
    func reset() {
        self.parentCoordinator?.start()
    }
    
    func presentChangeAlert() {
        let alert = factory.createWarningAlert(coordinator: self)
        navigationController.present(alert, animated: true)
    }
    
    func presetLogOutAlert() {
        let alert = factory.createLogOutAlert(coordinator: self)
        navigationController.present(alert, animated: true)
    }
    
    func logout() {
        UserDefaults.standard.removeAll()
        self.reset()
    }
}
