//
//  MainCoordinator+LogoutAlertCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 22/01/2023.
//

import Foundation

extension MainCoordinator: LogoutAlertCoordinator {
    func logout() {
        UserDefaults.standard.removeAll()
        self.reset()
    }
}
