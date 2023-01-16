//
//  MainCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit
import QuickSheet

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

protocol TimelineCoordinator: AnyObject {
    func shouldPresentImageView(with url: URL?)
    func shouldPresentCreateTweetView(_ type: TweetPostType)
    func shouldNavigateToSettings()
}

extension MainCoordinator: TimelineCoordinator {
    func shouldPresentImageView(with url: URL?) {
        let viewController = ImageViewPopup()
        viewController.imageURL = url
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: true)
    }
    
    func shouldPresentCreateTweetView(_ type: TweetPostType) {
        let viewController = CreateTweetPopup()
        viewController.postType = type
        navigationController.presentQuickSheet(viewController, options: .scrollableHalf)
    }
    
    func shouldNavigateToSettings() {
        let viewController = PreferencesVC()
        navigationController.pushViewController(viewController, animated: true)
    }
}
