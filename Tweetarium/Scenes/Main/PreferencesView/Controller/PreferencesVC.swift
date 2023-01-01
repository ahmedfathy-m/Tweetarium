//
//  PreferencesVC.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 31/12/2022.
//

import UIKit

class PreferencesVC: AFViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let preferences = [PreferenceItem(name: "Enable Dark Mode", key: "color_scheme", source: .local, valueSource: .switchable)]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PreferencesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = preferences[indexPath.row].name
        return cell
    }
}
