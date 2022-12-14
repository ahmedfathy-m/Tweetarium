//
//  TimelineViewModel.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 14/12/2022.
//

import Foundation

class TimelineViewModel {
    // MARK: - Binding
    fileprivate var onDataFetch: ()->()
    
    init(onDataFetch: @escaping () -> Void) {
        self.onDataFetch = onDataFetch
    }
    
    // MARK: - Model
    fileprivate var model = Timeline()
    
    // MARK: - ViewModel
    private(set) var tweets = [TweetViewModel]()
    
    // MARK: - Intent
    func fetchTimeline(handler: ActivityHandler? = nil) async {
        let route = Main.home
        guard let timeline: Timeline = await NetworkService.shared.loadData(from: route, handler: handler) else { return }
        tweets = timeline.map({TweetViewModel.init(model: $0 )})
        print(tweets.count)
        print(#function)
        onDataFetch()
    }
}
