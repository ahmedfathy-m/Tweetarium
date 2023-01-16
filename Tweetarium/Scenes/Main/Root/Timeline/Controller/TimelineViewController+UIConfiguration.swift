//
//  TimelineViewController+UIConfiguration.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/01/2023.
//

import UIKit

extension TimelineViewController {
    // MARK: - UI Configuration
    func prepareListOfTweets() {
        tweetsTable.delegate = self
        tweetsTable.dataSource = self
        tweetsTable.prefetchDataSource = self
        tweetsTable.addSubview(tweetsRefreshControl)
        
        let tweetCellNib = UINib(nibName: "TweetObjectView", bundle: nil)
        self.tweetsTable.register(tweetCellNib, forCellReuseIdentifier: "TweetObjectView")
    }


    func configureAddTweetButtonOnAppear() {
        addTweetButton.layer.shadowColor = UIColor.black.cgColor
        addTweetButton.layer.shadowRadius = 5
        addTweetButton.layer.shadowOpacity = 0.25
        addTweetButton.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
