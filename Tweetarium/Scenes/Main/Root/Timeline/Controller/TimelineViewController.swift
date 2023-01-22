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
    var viewModel: TimelineViewModelProtocol!
    
    // MARK: - TabBarController
    var rootController: RootTabbarControllerProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareListOfTweets()
        bindTimeline()
        viewModel.reloadTimeline(handler: self)
        viewModel.fetchUserDetails(handler: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureAddTweetButtonOnAppear()
    }
    
    // MARK: - IBActions
    @objc func reloadTweets(_ sender: UIRefreshControl) {
        Task {
            viewModel.reloadTimeline(handler: self)
            sender.endRefreshing()
        }
    }
    
    @IBAction func didPressAddTweet(_ sender: UIButton) {
        coordinator?.shouldPresentCreateTweetView(.tweet)
    }

}
