//
//  CreateTweetViewModelProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 17/01/2023.
//

import Foundation

protocol CreateTweetViewModelProtocol {
    var user: Observable<UserViewModel> { get set }
    var createdTweet: Observable<TweetViewModel> { get set }
    var subtweet: Observable<TweetViewModel> { get set }
    var tweetCount: Observable<Int> { get set }
    var isPostingAllowed: Observable<Bool> { get set }
    
    func fetchUserData(_ handler: ActivityHandler?)
    func fetchSubtweet(tweetID:Int64, _ handler: ActivityHandler?) async
    func postTweet(text: String, type: TweetPostType, handler: ActivityHandler?)
    func observeTextChange(_ value: String, isPlaceHolder: Bool)
}
