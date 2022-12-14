//
//  TimelineViewController.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 13/12/2022.
//

import UIKit
import SwiftUI

class TimelineViewController: AFViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tweetsTable: UITableView!
    
    // MARK: - ViewModel
    lazy var viewModel = TimelineViewModel {
        DispatchQueue.main.async { self.tweetsTable.reloadData() }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tweetsTable.delegate = self
        tweetsTable.dataSource = self
        Task { await viewModel.fetchTimeline(handler: self) }
    }
}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            TweetTableCell(tweet: viewModel.tweets[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
