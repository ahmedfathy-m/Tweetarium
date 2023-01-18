//
//  MainCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    // 1. INITIALIZER
    init(navigation: UINavigationController, parent: Coordinator? = nil) {
        self.navigationController = navigation
        self.parentCoordinator = parent
    }
    
    // 2. COORDINATOR PROTOCOL
    var parentCoordinator: Coordinator?
    var childCoordinators: [String : Coordinator] = [:]
    var navigationController: UINavigationController
    var factory = ViewControllerFactory()
    
    func start() {
        let tabView = factory.buildTabBar(coordinator: self)
        navigationController.setViewControllers([tabView], animated: true)
    }
}
