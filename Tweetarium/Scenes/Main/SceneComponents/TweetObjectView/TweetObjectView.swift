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
    
    // MARK: - Component Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarOfOriginalAuthor.layer.cornerRadius = avatarOfOriginalAuthor.frame.height / 2
        avatarOfOriginalAuthor.kf.indicatorType = .activity
        tweetMediaGallery.dataSource = self
        tweetMediaGallery.delegate = self
        TweetMediaEntityView.register(for: tweetMediaGallery)
        tweetMediaGallery.layer.cornerRadius = 10
        tweetMediaGallery.clipsToBounds = true
        likeButton.imageView?.contentMode = .scaleAspectFit
        retweetButton.imageView?.contentMode = .scaleAspectFit
        
        viewOfQuotedStatus.layer.borderColor = UIColor.systemGray3.cgColor
        viewOfQuotedStatus.layer.borderWidth = 0.5
        viewOfQuotedStatus.layer.cornerRadius = 10
        avatarOfQuotedStatusAuthor.layer.cornerRadius = avatarOfQuotedStatusAuthor.frame.width / 2
        mediaEntityOfQuotedStatus.layer.cornerRadius = 5
        mediaEntityOfQuotedStatus.kf.indicatorType = .activity
        mediaEntityOfQuotedStatus.isHidden = true
        textOfOriginalTweet.textContainerInset = .zero
        textOfOriginalTweet.textContainer.lineFragmentPadding = .zero
        textOfOriginalTweet.delegate = self
        
        pageControlOfTweetGallery.backgroundStyle = .minimal
        pageControlOfTweetGallery.allowsContinuousInteraction = false
        enclosingViewOfPageControl.layer.cornerRadius = enclosingViewOfPageControl.frame.height / 2
        enclosingViewOfPageControl.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        enclosingViewOfPageControl.insertSubview(blurView, at: 0)
        enclosingViewOfPageControl.clipsToBounds = true
        
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.insertSubview(vibrancyView, at: 1)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: enclosingViewOfPageControl.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: enclosingViewOfPageControl.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: enclosingViewOfPageControl.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: enclosingViewOfPageControl.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vibrancyView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor),
            vibrancyView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
            vibrancyView.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor)
        ])
        
        self.configureUIMenu()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Register Nib
    static func registerFor(_ tableView: UITableView) {
        tableView.register(TweetObjectView.nib(), forCellReuseIdentifier: TweetObjectView.identifier)
    }
    
    static func instantiateCell(for tableView: UITableView, at indexPath: IndexPath, source: TweetViewModel) -> TweetObjectView {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetObjectView.identifier, for: indexPath) as! TweetObjectView
        cell.tweetID = Int(source.model.id)
        cell.nameOfOriginalAuthor.text = source.displayName
        cell.handleOfOriginalAuthor.text = source.displayHandle
        cell.timeSincePosting.text = "• \(source.postedSince)"
        cell.contentOfOriginalTweet.attributedText = source.displayText
        cell.textOfOriginalTweet.attributedText = source.displayText
        cell.contentOfOriginalTweet.textAlignment = source.isRightToLeft ? .right : .left
        cell.textOfOriginalTweet.textAlignment = source.isRightToLeft ? .right : .left
        cell.avatarOfOriginalAuthor.kf.setImage(with: source.imageURL)
        cell.retweetingHeader.isHidden = !source.isRetweet
        cell.displayNameOfRetweetingUser.text = source.retweetedBy
        cell.mediaEntities = source.mediaEntities
        cell.tweetMediaGallery.reloadData()
        cell.tweetMediaGallery.isHidden = source.mediaEntities.isEmpty
        if source.mediaEntities.count < 2 {
            cell.enclosingViewOfPageControl.isHidden = true
        } else {
            cell.enclosingViewOfPageControl.isHidden = false
            cell.pageControlOfTweetGallery.numberOfPages = source.mediaEntities.count
        }
        cell.enclosingViewOfTweetGallery.isHidden = source.mediaEntities.isEmpty
        cell.retweetButton.setTitle(source.numberOfRetweets, for: .normal)
        cell.retweetButton.isSelected = source.isRetweetedByUser
        cell.likeButton.isSelected = source.isLikedByUser
        cell.likeButton.setTitle(source.numberOfLikes, for: .normal)
        cell.viewOfQuotedStatus.isHidden = !source.isQuoted
        cell.nameOfQuotedStatusAuthor.text = source.nameOfQuotedStatusAuthor
        cell.handleOfQuotedStatusAuthor.text = source.handleOfQuotedStatusAuthor
        cell.textOfQuotedStatus.text = source.textOfQuotedStatus
        cell.textOfQuotedStatus.textAlignment = source.isQuotedStatusRTL ? .right : .left
        cell.avatarOfQuotedStatusAuthor.kf.setImage(with: source.avatarOfQuotedStatusAuthor)
        cell.mediaEntityOfQuotedStatus.isHidden = !source.quotedStatusHasMedia
        cell.mediaEntityOfQuotedStatus.kf.setImage(with: source.firstMediaEntityOfQuotedStatus)
        return cell
    }
    
    func configureUIMenu() {
        retweetButton.showsMenuAsPrimaryAction = true
        let retweet = UIAction(title: "Retweet", image: UIImage(systemName: "arrow.2.squarepath")) { action in
            self.didPressRetweet()
        }
        let quote = UIAction(title: "Quote Retweet", image: UIImage(systemName: "pencil")) { _ in
            self.didPressQuote()
        }
        retweetButton.menu = UIMenu(title: "Retweet", children: [retweet, quote])
    }
    
    // MARK: - Actions
    @IBAction func didPressLike(_ sender: UIButton) {
        Task {
            guard let updatedCount = await delegate?.didPressLike(at: Int64(self.tweetID), isAlreadyLiked: sender.isSelected) else { return }
            UIView.transition(with: sender, duration: 0.25, options: .transitionCrossDissolve) {
                sender.setTitle(updatedCount, for: .normal)
                sender.isSelected.toggle()
            }
        }
    }
    
    func didPressRetweet() {
        Task {
            guard let updatedCount = await delegate?.didPressRetweetStatus(at: Int64(self.tweetID), isAlreadyRetweeted: retweetButton.isSelected) else { return }
            UIView.transition(with: retweetButton, duration: 0.25, options: .transitionCrossDissolve) {
                self.retweetButton.setTitle(updatedCount, for: .normal)
                self.retweetButton.isSelected.toggle()
            }
        }
    }
    
    func didPressQuote() {
        delegate?.didPressQuoteRetweet(at: Int64(self.tweetID))
    }
    
    @IBAction func didPressReply(_ sender: UIButton) {
        delegate?.didPressReplyToTweet(to: Int64(self.tweetID))
    }
    // MARK: - Nib
    static private var identifier: String {
        return String(describing: self)
    }
    
    static private func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}
