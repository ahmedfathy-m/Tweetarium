//
//  CreateTweetPopup+Binding.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension CreateTweetPopup {
    func userBinding() {
        viewModel.user.bind { user in
            DispatchQueue.main.async {
                self.userName.text = user?.displayName
                self.userImage.kf.setImage(with: user?.displayImage)
                self.screenName.text = user?.twitterHandle
                self.tweetCount.text = user?.numberOfTweets
            }
        }
    }
    
    func subTweetBinding() {
        viewModel.subtweet.bind { tweet in
            DispatchQueue.main.async {
                self.subtweetText.attributedText = tweet?.displayText
                self.subtweetAuthorName.text = tweet?.displayName
                self.subtweetAuthorHandle.text = tweet?.displayHandle
                self.subtweetPostingTime.text = tweet?.postedSince
                self.subtweetAuthorAvi.kf.indicatorType = .activity
                self.subtweetAuthorAvi.kf.setImage(with: tweet?.imageURL)
            }
        }
    }
    
    func typeTweetBinding() {
        viewModel.tweetCount.bind { count in
            guard let count = count else { return }
            UIView.transition(with: self.charCountLabel, duration: 0.25, options: .transitionFlipFromTop) {
                self.charCountLabel.text = "\(count)/280"
            }
        }
        
        viewModel.isPostingAllowed.bind { allowed in
            guard let allowed = allowed else { return }
            UIView.transition(with: self.tweetButton, duration: 0.25, options: .transitionCrossDissolve) {
                self.tweetButton.isEnabled = allowed
                self.charCountLabel.textColor = allowed ? .black : .systemRed
            }
        }
    }
}
