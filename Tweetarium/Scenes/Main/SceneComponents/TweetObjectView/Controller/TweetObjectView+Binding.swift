//
//  TweetObjectView+Binding.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TweetObjectView {
    func bindLikeStatus() {
        viewModel.isLikedByUser.bind { isLiked in
            guard let isLiked = isLiked else { return }
            UIView.animate(withDuration: 0.25) {
                self.likeButton.isSelected = isLiked
            }
        }

        viewModel.numberOfLikes.bind { formattedLikes in
            guard let formattedLikes = formattedLikes else { return }
            UIView.transition(with: self.likeButton, duration: 0.25, options: .transitionFlipFromTop) {
                self.likeButton.setTitle(formattedLikes, for: .normal)
            }
        }
    }
    
    func bindRetweetStatus() {
        viewModel.isRetweetedByUser.bind { isRetweeted in
            guard let isRetweeted = isRetweeted else { return }
            UIView.animate(withDuration: 0.25) {
                self.retweetButton.isSelected = isRetweeted
            }
        }

        viewModel.numberOfRetweets.bind { formattedRetweets in
            guard let formattedRetweets = formattedRetweets else { return }
            UIView.transition(with: self.retweetButton, duration: 0.25, options: .transitionFlipFromTop) {
                self.retweetButton.setTitle(formattedRetweets, for: .normal)
            }
        }
    }
}
