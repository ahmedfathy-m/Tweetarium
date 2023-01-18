//
//  MainCoordinator+TimelineCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation
import QuickSheet

extension MainCoordinator: TimelineCoordinator {
    func shouldPresentImageView(with url: URL?) {
        let viewController = ImageViewPopup()
        viewController.imageURL = url
        viewController.modalPresentationStyle = .fullScreen
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
    
    func shouldPresentCreateTweetView(_ type: TweetPostType) {
        let viewController = CreateTweetPopup()
        viewController.viewModel = CreateTweetViewModel()
        viewController.postType = type
        navigationController.presentQuickSheet(viewController, options: .staticHalf)
    }
    
    func shouldNavigateToSettings() {
        let viewController = PreferencesVC()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
