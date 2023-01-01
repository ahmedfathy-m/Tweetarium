//
//  CreateTweetViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import Foundation

class CreateTweetViewModel {
    private(set) var user: Observable<UserViewModel> = Observable(nil)
    private(set) var createdTweet: Observable<TweetViewModel> = Observable(nil)
    private(set) var subtweet: Observable<TweetViewModel> = Observable(nil)
    
    // MARK: - Intent
    // 1. Loading the Screen -> Get User data
    func fetchUserData(_ handler: ActivityHandler?) async {
        guard let userId = Int(Defaults.userID.value as! String) else { return }
        let route = Users.show(userId)
        guard let userData: UserObject = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
        user.value = UserViewModel(user: userData)
    }
    
    // 1b. Loading the Screen -> Get Quoted/Replied Tweet Data
    func fetchSubtweet(tweetID:Int64, _ handler: ActivityHandler?) async {
        let route = Statuses.show(id: tweetID)
        guard let tweetObject: TweetObject = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
        subtweet.value = TweetViewModel(model: tweetObject)
    }
    
    // 2. Posting the tweet
    func postTweet(text: String, inReplyToTweet: Int64? = nil, isQuoting: Bool = false,_ handler: ActivityHandler?) async {
        var updatedText = text
        if isQuoting { updatedText.append(" \(subtweet.value!.tweetURL)") }
        let route = Statuses.create(text: updatedText, inReplyToTweetID: inReplyToTweet)
        guard let tweetObject: TweetObject = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
        createdTweet.value = TweetViewModel(model: tweetObject)
    }
}
