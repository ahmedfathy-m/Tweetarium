//
//  CreateTweetPopup+UIConfiguration.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit
import Kingfisher

extension CreateTweetPopup {
    // MARK: - UI Configuration
    func configureViewBasedOnType() {
        switch postType {
        case .quote(let tweetID) :
            tweetButton.setTitle("Quote", for: .normal)
            Task { await viewModel.fetchSubtweet(tweetID: tweetID, self) }
        case .reply(let tweetID):
            tweetButton.setTitle("Reply", for: .normal)
            Task { await viewModel.fetchSubtweet(tweetID: tweetID, self) }
        default:
            break
        }
    }
    
    func configureInterfaceOnAppear() {
        // Profile Header Configuration
        self.userImage.kf.indicatorType = .activity
        self.userImage.layer.cornerRadius = userImage.frame.height / 2
        self.userImage.clipsToBounds = true
        
        // Subtweet Configuration
        subtweetView.layer.cornerRadius = 10
        subtweetView.layer.borderColor = UIColor.systemGray4.cgColor
        subtweetView.layer.borderWidth = 1.5
        subtweetAuthorAvi.layer.cornerRadius = subtweetAuthorAvi.frame.height / 2
        tweetTextView.layer.cornerRadius = 10
        
        // Text View
        self.tweetTextView.delegate = self
        
        switch postType {
        case .tweet:
            subtweetView.isHidden = true
        case .quote, .reply:
            subtweetView.isHidden = false
        }
    }
}
