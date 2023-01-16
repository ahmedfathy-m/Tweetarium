//
//  TweetObjectView.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/12/2022.
//

import UIKit
import Kingfisher

class TweetObjectView: UITableViewCell {
    // MARK: - TweetObjectDelegate
    weak var delegate: TweetObjectDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tweetStack: UIStackView!
    @IBOutlet weak var nameOfRetweetingUser: UILabel!
    @IBOutlet weak var nameOfOriginalAuthor: UILabel!
    @IBOutlet weak var handleOfOriginalAuthor: UILabel!
    @IBOutlet weak var timeSincePosting: UILabel!
    @IBOutlet weak var contentOfOriginalTweet: UILabel!
    @IBOutlet weak var textOfOriginalTweet: UITextView!
    @IBOutlet weak var avatarOfOriginalAuthor: UIImageView!
    @IBOutlet weak var retweetingHeader: UIView!
    @IBOutlet weak var displayNameOfRetweetingUser: UILabel!
    @IBOutlet weak var tweetMediaGallery: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var viewOfQuotedStatus: UIView!
    @IBOutlet weak var nameOfQuotedStatusAuthor: UILabel!
    @IBOutlet weak var handleOfQuotedStatusAuthor: UILabel!
    @IBOutlet weak var avatarOfQuotedStatusAuthor: UIImageView!
    @IBOutlet weak var textOfQuotedStatus: UILabel!
    @IBOutlet weak var mediaEntityOfQuotedStatus: UIImageView!
    @IBOutlet weak var enclosingViewOfPageControl: UIView!
    @IBOutlet weak var enclosingViewOfTweetGallery:UIView!
    @IBOutlet weak var pageControlOfTweetGallery: UIPageControl!
    var mediaEntities = [URL?]()
    var tweetID = 0
    
    // MARK: - Tweet View Model
    var viewModel: TweetViewModel!
    
    // MARK: - Component Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initialUIConfiguration()
        configureUIMenu()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func didPressLike(_ sender: UIButton) {
        viewModel.likeTweet(isLiked: sender.isSelected)
    }
    
    func didPressRetweet() {
        viewModel.retweetStatus(isRetweeted: retweetButton.isSelected)
    }
    
    func didPressQuote() {
        delegate?.didPressQuoteRetweet(at: Int64(viewModel.tweetID))
    }
    
    @IBAction func didPressReply(_ sender: UIButton) {
        delegate?.didPressReplyToTweet(to: Int64(viewModel.tweetID))
    }
}
