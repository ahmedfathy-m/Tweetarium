//
//  TwitterUserHeader+UIConfiguration.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import Foundation

extension TwitterUserHeader {
    // MARK: - Configurations
    func makeCircularImage() {
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        imageView.kf.indicatorType = .activity
    }
    
    func configure(with screenType: TimelineType?) {
        switch screenType {
        case .home, .mentions:
            titleLabel.text = screenType?.title
            numberOfTweets.isHidden = true
        case .profile:
            titleLabel.text = screenName
            numberOfTweets.isHidden = false
        case .none:
            titleLabel.text = "Tweetarium"
            numberOfTweets.isHidden = true
        }
    }
}
