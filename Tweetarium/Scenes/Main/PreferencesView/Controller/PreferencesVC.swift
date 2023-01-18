//
//  PreferencesVC.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 16/01/2023.
//

import UIKit
import Eureka

class PreferencesVC: FormViewController {
    // MARK: - Coordinator
    weak var coordinator: PreferencesCoordinator?
    
    // MARK: - Life Cycle
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Preferences"~)
        <<< SwitchRow(){ row in
            row.title = "Enable Dark Mode"~
            row.onChange { row in
                guard let window = self.view.window else { return }
                guard let value = row.value else { return }
                UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve) {
                    window.backgroundColor = value ? .black : .white
                    window.overrideUserInterfaceStyle = value ? .dark : .light
                }
                UserDefaults.standard.isDarkModeEnabled = value
            }
            row.value = UserDefaults.standard.isDarkModeEnabled
        }
        <<< ActionSheetRow<String>(){
            $0.title = "Language"~
            $0.options = ["العربية", "English"]
            if UserDefaults.standard.currentLanguage == "en" {
                $0.value = "English"
            } else if UserDefaults.standard.currentLanguage == "ar" {
                $0.value = "العربية"
            }
            $0.onChange { row in
                guard let value = row.value else { return }
                if value == "English" {
                    UserDefaults.standard.setLanguage("en")
                } else if value == "العربية" {
                    UserDefaults.standard.setLanguage("ar")
                }
                self.coordinator?.presentChangeAlert()
            }
        }
        +++ Section("Account"~)
        <<< ButtonRow() {
            $0.title = "Logout"~
            $0.onCellSelection { cell, row in
                self.coordinator?.presetLogOutAlert()
            }
        }
        +++ Section("Developer"~)
        <<< ButtonRow(){
            $0.title = "Visit Repository.."~
            $0.onCellSelection { cell, row in
                UIApplication.shared.open(URL(string: "https://github.com/ahmedfathy-m/Tweetarium")!)
            }
        }
        <<< ButtonRow(){
            $0.title = "Follow Me on LinkedIn"~
            $0.onCellSelection { cell, row in
                UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/ahmedfathy-mha/")!)
            }
        }
        <<< ButtonRow(){
            $0.title = "Follow Me on Github"~
            $0.onCellSelection { cell, row in
                UIApplication.shared.open(URL(string: "https://github.com/ahmedfathy-m")!)
            }
        }
    }
}
