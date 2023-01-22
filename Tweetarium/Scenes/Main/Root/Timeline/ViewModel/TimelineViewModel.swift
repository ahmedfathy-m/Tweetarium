//
//  TimelineViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

class TimelineViewModel: TimelineViewModelProtocol {
    // MARK: - Model
    fileprivate var model = Timeline()
    fileprivate var route: NetworkingRoute
    fileprivate var lastTweetID: Int?
    fileprivate var isLoading: Bool = false
    
    private init(_ route: NetworkingRoute) {
        self.route = route
    }
    
    convenience init(_ type: TimelineType?) {
        switch type {
        case .home: self.init(Statuses.home())
        case .mentions: self.init(Statuses.mentions())
        case .profile: self.init(Statuses.profile())
        case .none: self.init(Statuses.home())
        }
    }
    
    // MARK: - Observables
    var tweets: Observable<[TweetViewModel]> = Observable([])
    var user: Observable<UserObject> = Observable(nil)
    
    // MARK: - Intent
    func reloadTimeline(handler: ActivityHandler? = nil) {
        self.lastTweetID = nil
        fetchTimeline(handler: handler)
    }
    
    func fetchTimeline(handler: ActivityHandler? = nil) {
        Task {
            guard !isLoading else { return }
            if let lastTweetID = lastTweetID {
                isLoading = true
                switch route {
                case Statuses.home: route = Statuses.home(maxID: lastTweetID)
                case Statuses.mentions: route = Statuses.mentions(maxID: lastTweetID)
                case Statuses.profile: route = Statuses.profile(maxID: lastTweetID)
                default: break
                }
                guard let timeline: Timeline = await NetworkService.shared.loadData(from: self.route, handler: handler) else {
                    isLoading = false
                    return
                }
                isLoading = false
                self.lastTweetID = Int(timeline.last?.id ?? 0)
                tweets.value?.append(contentsOf: timeline.map({TweetViewModel.init(model: $0)}))
            } else {
                guard let timeline: Timeline = await NetworkService.shared.loadData(from: self.route, handler: handler) else { return }
                tweets.value = timeline.map({TweetViewModel.init(model: $0)})
                self.lastTweetID = Int(timeline.last?.id ?? 0)
            }
        }
    }
    
    func fetchUserDetails(handler: ActivityHandler? = nil) {
        Task {
            guard let userID = Int(UserDefaults.standard.userID ?? "0") else { return }
            let userRoute = Users.show(userID)
            guard let userData: UserObject = await NetworkService.shared.loadData(from: userRoute, handler: handler) else { return }
            user.value = userData
        }
    }
}
