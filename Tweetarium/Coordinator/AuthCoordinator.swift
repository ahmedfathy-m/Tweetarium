//
//  AuthCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class AuthCoordinator: Coordinator {
    // 1. INITIALIZER
    init(navigation: UINavigationController, parent: Coordinator? = nil) {
        self.navigationController = navigation
        self.parentCoordinator = parent
    }
    
    // 2. COORDINATOR PROTOCOL
    var parentCoordinator: Coordinator?
    var childCoordinators: [String : Coordinator] = [:]
    var navigationController: UINavigationController
    
    func start() {
        let loadingVC = LoadingViewController()
        loadingVC.coordinator = self
        loadingVC.viewModel = LoadingViewModel()
        navigationController.setViewControllers([loadingVC], animated: true)
    }
    
    func didSuccessfullyLogin() {
        if let main = self.parentCoordinator?.childCoordinators["Main"] {
            main.start()
        }
    }
}
