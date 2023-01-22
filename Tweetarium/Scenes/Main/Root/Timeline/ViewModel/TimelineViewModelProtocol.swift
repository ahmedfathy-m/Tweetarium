//
//  TimelineViewModelProtocol.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import Foundation

protocol TimelineViewModelProtocol: AnyObject {
    // MARK: - Observables
    var tweets: Observable<[TweetViewModel]> { get set }
    var user: Observable<UserObject> { get set }
    
    // MARK: - Intents
    func fetchTimeline(handler: ActivityHandler?)
    func fetchUserDetails(handler: ActivityHandler?)
    func reloadTimeline(handler: ActivityHandler?)
}
