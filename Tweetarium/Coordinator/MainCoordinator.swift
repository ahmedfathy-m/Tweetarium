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
    
    func start() {
        let tabView = RootTabbarController()
        tabView.viewControllers?.forEach { viewController in
            guard let viewController = viewController as? TimelineViewController else { return }
            viewController.coordinator = self
        }
        navigationController.setViewControllers([tabView], animated: true)
    }
    
    func shouldPresentImageView(with url: URL?) {
        let viewController = ImageViewPopup()
        viewController.imageURL = url
        navigationController.present(viewController, animated: true)
    }
}
