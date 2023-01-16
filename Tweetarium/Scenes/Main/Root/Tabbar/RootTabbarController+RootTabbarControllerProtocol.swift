//
//  RootTabbarController+RootTabbarControllerProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import Foundation

extension RootTabbarController: RootTabbarControllerProtocol {
    func relayUserInfoToHeaderDelegate(user: UserObject) {
        self.user = user
    }
}
