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
    
    fileprivate func constructTabBar() -> UITabBarController {
        let tabBarController = RootTabbarController()
        tabBarController.coordinator = self
        let customHeader = TwitterUserHeader.instantiateWithWidth(UIScreen.main.bounds.width)
        tabBarController.customHeader = customHeader
        customHeader.delegate = tabBarController
        let screenTypes: [TimelineType] = [.mentions, .home, .profile]
        let views: [TimelineViewController] = screenTypes.map { type in
            let viewController = TimelineViewController()
            viewController.coordinator = self
            viewController.configureTitles(type)
            return viewController
        }
        tabBarController.setViewControllers(views, animated: true)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
    
    func start() {
        let tabView = constructTabBar()
        navigationController.setViewControllers([tabView], animated: true)
    }
}

protocol TimelineCoordinator: AnyObject {
    func shouldPresentImageView(with url: URL?)
    func shouldPresentCreateTweetView(_ type: CreateTweetViewType)
    func shouldNavigateToSettings()
}

extension MainCoordinator: TimelineCoordinator {
    func shouldPresentImageView(with url: URL?) {
        let viewController = ImageViewPopup()
        viewController.imageURL = url
        navigationController.present(viewController, animated: true)
    }
    
    func shouldPresentCreateTweetView(_ type: CreateTweetViewType) {
        let viewController = CreateTweetPopup()
        viewController.viewType = type
        navigationController.present(viewController, animated: true)
    }
    
    func shouldNavigateToSettings() {
        let viewController = PreferencesVC()
        navigationController.pushViewController(viewController, animated: true)
    }
}
