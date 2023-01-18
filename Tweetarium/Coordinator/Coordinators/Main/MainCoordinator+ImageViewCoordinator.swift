//
//  MainCoordinator+ImageViewCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation

extension MainCoordinator: ImageViewCoordinator {
    func presentImageSaveMessage() {
        let alert = factory.createSuccessMessage(message: "Image was saved successfully"~)
        navigationController.presentedViewController?.present(alert, animated: true)
    }
}
