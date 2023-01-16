//
//  TwitterUserHeader+TwitterHeaderProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import Foundation
import Kingfisher

extension TwitterUserHeader: TwitterHeaderProtocol {
    func showUserInfo(name: String, count: Int, image: URL?) {
        titleLabel.text = name
        numberOfTweets.text = count.formattedInKFormat
        numberOfTweets.isHidden = false
        imageView.kf.setImage(with: image)
    }
    
    func showTitle(_ value: String) {
        numberOfTweets.isHidden = true
        titleLabel.text = value
    }
}
