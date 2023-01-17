//
//  ImageViewPopup.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import UIKit
import Kingfisher

class ImageViewPopup: AFViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    var imageURL: URL?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
    }
    
    // MARK: - IBActions
    @IBAction func willDismissView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
