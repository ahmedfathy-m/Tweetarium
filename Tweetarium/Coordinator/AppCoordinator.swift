//
//  AppCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    // 1. INITIALIZER
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
        
    // 2. COORDINATOR PROTOCOL
    lazy var childCoordinators: [String: Coordinator] = [
        "Main" : MainCoordinator(navigation: self.navigationController, parent: self),
        "Auth" : AuthCoordinator(navigation: self.navigationController, parent: self)
    ]
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var isLoggedIn: Bool {
        UserDefaults.standard.userID?.isEmpty == false
    }
    
    func start() {
        if isLoggedIn {
            childCoordinators["Main"]?.start()
        } else {
            childCoordinators["Auth"]?.start()
        }
    }
}
