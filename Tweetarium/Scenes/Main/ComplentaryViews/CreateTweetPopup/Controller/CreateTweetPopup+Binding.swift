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
            print("Current Tweet Count: \(count)")
        }
        
        viewModel.isPostingAllowed.bind { value in
            guard let value = value else { return }
            print("Posting is\(value ? "" : "not") allowed")
        }
    }
}
