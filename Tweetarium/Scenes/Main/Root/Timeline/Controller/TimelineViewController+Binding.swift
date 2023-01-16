//
//  TimelineViewController+Binding.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TimelineViewController {
    func bindTimeline() {
        viewModel.tweets.bind { tweets in
            self.tweetsTable.reloadData()
        }
        
        viewModel.user.bind { user in
            guard let user = user else { return }
            self.rootController.relayUserInfoToHeaderDelegate(user: user)
        }
    }
}
