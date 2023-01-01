//
//  TweetObjectView + Collection View.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 30/12/2022.
//

import UIKit

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
        delegate?.didSelectImage(imageURL: mediaEntities[selectedIndex]?.absoluteURL)
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
