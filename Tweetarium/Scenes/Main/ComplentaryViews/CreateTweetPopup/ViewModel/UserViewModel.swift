//
//  UserViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import Foundation

struct UserViewModel {
    let user: UserObject
}

extension UserViewModel {
    var displayName: String {
        return user.name
    }
    
    var twitterHandle: String {
        return "@\(user.screenName)"
    }
    
    var numberOfTweets: String {
        return "\(user.tweetsCount.formattedInKFormat) Tweets"
    }
    
    var displayImage: URL? {
        return user.profileImage
    }
    
    var headerImage: URL? {
        return user.headerURL
    }
}
