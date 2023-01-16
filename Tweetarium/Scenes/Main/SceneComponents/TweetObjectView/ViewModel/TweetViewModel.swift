//
//  TweetViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

class TweetViewModel {
    // MARK: - Model
    let model: TweetObject
    
    // MARK: - Init
    init(model: TweetObject) {
        self.model = model
        
        // Publish Initial Values for likes and retweets
        isLikedByUser.value = model.isLikedByAuthenticatedUser
        numberOfLikes.value = model.numberOfLikes?.formattedInKFormat
        isRetweetedByUser.value = model.isRetweetedByAuthenticatedUser
        numberOfRetweets.value = model.numberOfRetweets.formattedInKFormat
    }
    
    // MARK: - Observables
    private(set) var isLikedByUser: Observable<Bool> = Observable(nil)
    private(set) var isRetweetedByUser: Observable<Bool> = Observable(nil)
    private(set) var numberOfRetweets: Observable<String> = Observable(nil)
    private(set) var numberOfLikes: Observable<String> = Observable(nil)
    
    // MARK: - Intent
    
    /// Triggered when the like button is pressed. Calls the Statuses/favourite endpoint
    func likeTweet(isLiked: Bool) {
        // Returns number of likes after engagement
        Task {
            let route = isLiked ? Actions.unlike(id: Int(self.tweetID)) : Actions.like(id: Int(self.tweetID))
            guard let model: TweetObject = await NetworkService.shared.loadData(from: route) else { return }
            isLikedByUser.value = model.isLikedByAuthenticatedUser
            numberOfLikes.value = model.numberOfLikes?.formattedInKFormat
        }
    }
    
    /// Triggered when the retweet option is pressed. Calls the Statuses/retweet endpoint
    func retweetStatus(isRetweeted: Bool) {
        // Returns number of retweets after engagement
        Task {
            let route = isRetweeted ? Actions.unretweet(id: Int(model.id)) : Actions.retweet(id: Int(model.id))
            guard let model: TweetObject = await NetworkService.shared.loadData(from: route) else { return }
            isRetweetedByUser.value = model.isRetweetedByAuthenticatedUser
            numberOfRetweets.value = model.numberOfRetweets.formattedInKFormat
        }
    }
}
