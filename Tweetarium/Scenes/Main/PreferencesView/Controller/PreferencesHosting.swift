//
//  PreferencesHosting.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 20/01/2023.
//

import UIKit
import SwiftUI

class PreferencesHostingController: UIViewController {
    // MARK: - Coordinator
    weak var coordinator: PreferencesCoordinator?
    
    // MARK: - SwiftUI View
    lazy var contentView = UIHostingController(rootView: Preferences {
        self.coordinator?.presetLogOutAlert()
    } didChangeLanguage: { language in
        UserDefaults.standard.setLanguage(language)
        UIView.updateViewsDirection()
        self.coordinator?.reset()
    })
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        view.addSubview(contentView.view)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
