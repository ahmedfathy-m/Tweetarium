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
    fileprivate let route: NetworkingRoute
    
    private init(_ route: NetworkingRoute) {
        self.route = route
    }
    
    convenience init(_ type: TimelineType?) {
        switch type {
        case .home: self.init(Statuses.home)
        case .mentions: self.init(Statuses.mentions)
        case .profile: self.init(Statuses.profile)
        case .none: self.init(Statuses.home)
        }
    }
    
    // MARK: - Observables
    var tweets: Observable<[TweetViewModel]> = Observable([])
    var user: Observable<UserObject> = Observable(nil)
    
    // MARK: - Intent
    func fetchTimeline(handler: ActivityHandler? = nil) {
        Task {
            guard let timeline: Timeline = await NetworkService.shared.loadData(from: self.route, handler: handler) else { return }
            tweets.value = timeline.map({TweetViewModel.init(model: $0)})
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
