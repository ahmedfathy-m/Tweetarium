//
//  MainCoordinator+ImageViewCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation
import QuickSheet

extension MainCoordinator: ImageViewCoordinator {
    func presentImageSaveMessage() {
        let alert = factory.createSuccessMessage(message: "Image was saved successfully"~)
        let options = QuickSheetOptions(fraction: 0.45, isExpandable: false, isScrollable: false, cornerRadius: 20)
        navigationController.presentedViewController?.presentQuickSheet(alert, options: options)
//        navigationController.presentedViewController?.present(alert, animated: true)
    }
}
