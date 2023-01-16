//
//  TweetObjectDelegate.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import Foundation

protocol TweetObjectDelegate: AnyObject {
    /// Handles presentation of fullscreen image
    func didSelectImage(imageURL: URL?)
    
    /// Handles presentation of quote retweet screen
    func didPressQuoteRetweet(at tweetID: Int64)
    
    /// Handles presentation of reply tweet screen
    func didPressReplyToTweet(to tweetID: Int64)
}
