//
//  CreateTweetViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import Foundation

class CreateTweetViewModel: CreateTweetViewModelProtocol {
    // MARK: - Observables
    var user: Observable<UserViewModel> = Observable(nil)
    var createdTweet: Observable<TweetViewModel> = Observable(nil)
    var subtweet: Observable<TweetViewModel> = Observable(nil)
    var tweetCount: Observable<Int> = Observable(nil)
    var isPostingAllowed: Observable<Bool> = Observable(nil)
    
    // MARK: - Intent
    // 1. Loading the Screen -> Get User data
    func fetchUserData(_ handler: ActivityHandler?) {
        Task {
            guard let userId = Int(Defaults.userID.value as! String) else { return }
            let route = Users.show(userId)
            guard let userData: UserObject = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
            user.value = UserViewModel(user: userData)
        }
    }
    
    // 1b. Loading the Screen -> Get Quoted/Replied Tweet Data
    func fetchSubtweet(tweetID:Int64, _ handler: ActivityHandler?) async {
        let route = Statuses.show(id: tweetID)
        guard let tweetObject: TweetObject = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
        subtweet.value = TweetViewModel(model: tweetObject)
    }
    
    func postTweet(text: String, type: TweetPostType, handler: ActivityHandler?) {
        Task {
            guard isPostingAllowed.value == true else { return }
            var route: NetworkingRoute?
            switch type {
            case .tweet:
                route = Statuses.create(text: text, inReplyToTweetID: nil)
            case .quote:
                route = Statuses.create(text: subtweet.value!.tweetURL, inReplyToTweetID: nil)
            case .reply(let id):
                route = Statuses.create(text: text, inReplyToTweetID: id)
            }
            guard let tweetObject: TweetObject = await NetworkService.shared.loadData(from: route!, handler: handler) else { return }
            createdTweet.value = TweetViewModel(model: tweetObject)
            handler?.shouldDismiss()
        }
    }
    
    func observeTextChange(_ value: String, isPlaceHolder: Bool) {
        tweetCount.value = value.count
        if value.count <= 280 && !isPlaceHolder {
            isPostingAllowed.value = true
        } else {
            isPostingAllowed.value = false
        }
    }
}
