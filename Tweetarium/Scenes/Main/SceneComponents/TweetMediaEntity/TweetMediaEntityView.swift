//
//  TweetMediaEntityView.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/12/2022.
//

import UIKit

class TweetMediaEntityView: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var imageOfMediaEntity: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Nib
    static func instantiateCell(mediaEntity: URL?, for collectionView: UICollectionView, at indexPath: IndexPath) -> TweetMediaEntityView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetMediaEntityView.identifier, for: indexPath) as! TweetMediaEntityView
        cell.imageOfMediaEntity.kf.indicatorType = .activity
        cell.imageOfMediaEntity.kf.setImage(with: mediaEntity)
        return cell
    }
    
    static var identifier = String(describing: TweetMediaEntityView.self)
    
    static func register(for collectionView: UICollectionView) {
        let nib = UINib(nibName: TweetMediaEntityView.identifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: TweetMediaEntityView.identifier)
    }
}
