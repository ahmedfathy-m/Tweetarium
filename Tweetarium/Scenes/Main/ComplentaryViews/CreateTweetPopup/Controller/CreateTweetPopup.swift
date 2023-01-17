//
//  CreateTweetPopup.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import UIKit
import Kingfisher

class CreateTweetPopup: AFViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var subtweetView: UIView!
    @IBOutlet weak var subtweetAuthorName: UILabel!
    @IBOutlet weak var subtweetAuthorHandle: UILabel!
    @IBOutlet weak var subtweetPostingTime: UILabel!
    @IBOutlet weak var subtweetAuthorAvi: UIImageView!
    @IBOutlet weak var subtweetText: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    
    // MARK: - Coordinator
    weak var coordinator: Coordinator?
    
    // MARK: - ViewModel
    var viewModel: CreateTweetViewModelProtocol!
    
    // MARK: - Post Type
    var postType: TweetPostType = .tweet

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userBinding()
        subTweetBinding()
        typeTweetBinding()
        viewModel.fetchUserData(self)
        configureViewBasedOnType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureInterfaceOnAppear()
    }
    
    override func viewDidLayoutSubviews() {
        subtweetText.sizeToFit()
    }
    
    // MARK: - IBActions
    @IBAction func didPressDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressTweet(_ sender: UIButton) {
        viewModel.postTweet(text: tweetTextView.text, type: self.postType, handler: self)
    }
}
