//
//  TweetObjectView.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 15/12/2022.
//

import UIKit
import Kingfisher

class TweetObjectView: UITableViewCell {
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
    fileprivate var mediaEntities = [URL?]()
    fileprivate var didSelectImage: ((URL?) -> Void)?
    
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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Register Nib
    static func registerFor(_ tableView: UITableView) {
        tableView.register(TweetObjectView.nib(), forCellReuseIdentifier: TweetObjectView.identifier)
    }
    
    static func instantiateCell(for tableView: UITableView, at indexPath: IndexPath, source: TweetViewModel, didSelectImage: @escaping (URL?)->Void ) -> TweetObjectView {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetObjectView.identifier, for: indexPath) as! TweetObjectView
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
        cell.didSelectImage = didSelectImage
        return cell
    }
    
    static private var identifier: String {
        return String(describing: self)
    }
    
    static private func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}

extension TweetObjectView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaEntities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mediaEntity = self.mediaEntities[indexPath.item]
        let cell = TweetMediaEntityView.instantiateCell(mediaEntity: mediaEntity, for: tweetMediaGallery, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = pageControlOfTweetGallery.currentPage
        didSelectImage?(mediaEntities[selectedIndex]?.absoluteURL)
        print(mediaEntities[selectedIndex]?.absoluteURL)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControlOfTweetGallery.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

extension TweetObjectView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = collectionView.frame.width
        return CGSize(width: length, height: length)
    }
}

extension TweetObjectView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(characterRange)
        print(interaction.rawValue)
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}
