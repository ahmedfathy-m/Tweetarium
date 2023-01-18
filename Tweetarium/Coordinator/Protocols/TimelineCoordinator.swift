//
//  TimelineCoordinator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 18/01/2023.
//

import Foundation

protocol TimelineCoordinator: AnyObject {
    func shouldPresentImageView(with url: URL?)
    func shouldPresentCreateTweetView(_ type: TweetPostType)
    func shouldNavigateToSettings()
}
