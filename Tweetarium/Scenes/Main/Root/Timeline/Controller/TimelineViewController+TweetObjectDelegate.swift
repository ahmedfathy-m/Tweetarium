//
//  TimelineViewController+TweetCellDelegate.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import Foundation

extension TimelineViewController: TweetObjectDelegate {
    func didPressReplyToTweet(to tweetID: Int64) {
        coordinator?.shouldPresentCreateTweetView(.reply(tweetID))
    }
    
    func didSelectImage(imageURL: URL?) {
        coordinator?.shouldPresentImageView(with: imageURL)
    }
    
    func didPressQuoteRetweet(at tweetID: Int64) {
        coordinator?.shouldPresentCreateTweetView(.quote(tweetID))
    }
}
