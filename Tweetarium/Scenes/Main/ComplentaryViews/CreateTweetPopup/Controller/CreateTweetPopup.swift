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
    
    // MARK: - Coordinator
    weak var coordinator: Coordinator?
    
    // MARK: - ViewModel
    let viewModel = CreateTweetViewModel()
    
    // MARK: - View Configurations
    var viewType: CreateTweetViewType = .tweet

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.user.bind { user in
            DispatchQueue.main.async {
                self.userName.text = user?.displayName
                self.userImage.kf.setImage(with: user?.displayImage)
                self.screenName.text = user?.twitterHandle
                self.tweetCount.text = user?.numberOfTweets
            }
        }
        viewModel.subtweet.bind { tweet in
            DispatchQueue.main.async {
                self.subtweetText.attributedText = tweet?.displayText
                self.subtweetAuthorName.text = tweet?.displayName
                self.subtweetAuthorHandle.text = tweet?.displayHandle
                self.subtweetPostingTime.text = tweet?.postedSince
                self.subtweetAuthorAvi.kf.indicatorType = .activity
                self.subtweetAuthorAvi.kf.setImage(with: tweet?.imageURL)
            }
        }
        Task { await viewModel.fetchUserData(self) }
        switch viewType {
        case .quote(let tweetID), .reply(let tweetID) :
            Task { await viewModel.fetchSubtweet(tweetID: tweetID, self) }
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Profile Header Configuration
        self.userImage.kf.indicatorType = .activity
        self.userImage.layer.cornerRadius = userImage.frame.height / 2
        self.userImage.clipsToBounds = true
        
        // Subtweet Configuration
        subtweetView.layer.cornerRadius = 10
        subtweetView.layer.borderColor = UIColor.systemGray4.cgColor
        subtweetView.layer.borderWidth = 1.5
        subtweetAuthorAvi.layer.cornerRadius = subtweetAuthorAvi.frame.height / 2
        
        switch viewType {
        case .tweet:
            subtweetView.isHidden = true
        case .quote, .reply:
            subtweetView.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        subtweetText.sizeToFit()
    }
    
    // MARK: - IBActions
    @IBAction func didPressDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressTweet(_ sender: UIButton) {
        Task {
            switch viewType {
            case .tweet:
                await viewModel.postTweet(text: tweetTextView.text, self)
            case .quote:
                await viewModel.postTweet(text: tweetTextView.text, isQuoting: true, self)
            case .reply(let id):
                await viewModel.postTweet(text: tweetTextView.text, inReplyToTweet: id ,self)
            }
            self.dismiss(animated: true)
        }
    }
}

enum CreateTweetViewType {
    case tweet
    case quote(_ id: Int64)
    case reply(_ id: Int64)
}
