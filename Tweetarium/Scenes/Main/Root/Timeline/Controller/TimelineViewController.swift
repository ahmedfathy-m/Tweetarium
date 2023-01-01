//
//  TimelineViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import UIKit

class TimelineViewController: AFViewController {
    // MARK: - IBOutlets & UI Elements
    @IBOutlet weak var tweetsTable: UITableView!
    @IBOutlet weak var addTweetButton: UIButton!
    lazy var tweetsRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        control.addTarget(self, action: #selector(reloadTweets), for: .allEvents)
        return control
    }()
    
    // MARK: - Coordinator
    weak var coordinator: TimelineCoordinator?
    
    // MARK: - ViewModel
    private(set) var screenType: TimelineType?
    lazy private var viewModel = TimelineViewModel(screenType)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareListOfTweets()
        
        viewModel.tweets.bind { _ in
            DispatchQueue.main.async { self.tweetsTable.reloadData() }
        }
        
        viewModel.user.bind { user in
            DispatchQueue.main.async {
                guard let user = user else { return }
                guard let header = (self.tabBarController as? RootTabbarController)?.customHeader else { return}
                header.screenName = user.screenName
                header.tweetCount = user.tweetsCount
                header.imageView.kf.setImage(with: user.profileImage)
            }
        }
        
        Task { await viewModel.fetchTimeline(handler: self) }
        Task { await viewModel.fetchUserDetails(handler: self) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addTweetButton.layer.shadowColor = UIColor.black.cgColor
        addTweetButton.layer.shadowRadius = 5
        addTweetButton.layer.shadowOpacity = 0.25
        addTweetButton.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    // MARK: - IBActions
    @objc func reloadTweets(_ sender: UIRefreshControl) {
        Task {
            await viewModel.fetchTimeline(handler: self)
            sender.endRefreshing()
        }
    }
    
    @IBAction func didPressAddTweet(_ sender: UIButton) {
        coordinator?.shouldPresentCreateTweetView(.tweet)
    }
    
    // MARK: - UI Configuration
    func prepareListOfTweets() {
        tweetsTable.delegate = self
        tweetsTable.dataSource = self
        tweetsTable.prefetchDataSource = self
        tweetsTable.addSubview(tweetsRefreshControl)
        TweetObjectView.registerFor(tweetsTable)
    }
    
    func configureTitles(_ type: TimelineType) {
        self.screenType = type
        self.tabBarItem.title = type.title
        self.tabBarItem.image = UIImage(systemName: type.itemImage)
        self.tabBarItem.selectedImage = UIImage(systemName: "\(type.itemImage).fill")
    }
}

// MARK: - UITableView
extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let source = viewModel.tweets.value?[indexPath.row] else { return UITableViewCell() }
        let cell = TweetObjectView.instantiateCell(for: tableView, at: indexPath, source: source)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TimelineViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    }
}

extension TimelineViewController: TweetObjectDelegate {
    func didPressReplyToTweet(to tweetID: Int64) {
        coordinator?.shouldPresentCreateTweetView(.reply(tweetID))
    }
    
    func didPressLike(at tweetID: Int64, isAlreadyLiked: Bool) async -> String? {
        await viewModel.likeTweet(isLiked: isAlreadyLiked, for:Int(tweetID))
    }
    
    func didSelectImage(imageURL: URL?) {
        coordinator?.shouldPresentImageView(with: imageURL)
    }
    
    func didPressRetweetStatus(at tweetID: Int64, isAlreadyRetweeted: Bool) async -> String? {
        await viewModel.retweetStatus(isRetweeted: isAlreadyRetweeted, for: Int(tweetID))
    }
    
    func didPressQuoteRetweet(at tweetID: Int64) {
        coordinator?.shouldPresentCreateTweetView(.quote(tweetID))
    }
}
