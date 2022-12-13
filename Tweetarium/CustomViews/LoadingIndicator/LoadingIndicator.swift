//
//  LoadingIndicator.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import UIKit

class LoadingIndicator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = UIBlurEffect(style: .systemMaterial)
        return view
    }()
    
    lazy var indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        return imageView
    }()
    
    private var indicatorColor = UIColor.red
    
    override func layoutSubviews() {
        self.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 32),
            indicator.widthAnchor.constraint(equalToConstant: 32),
            self.heightAnchor.constraint(equalToConstant: 64),
            self.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
}
