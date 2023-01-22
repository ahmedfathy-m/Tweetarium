//
//  Preferences.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 20/01/2023.
//

import SwiftUI

struct Preferences: View {
    // MARK: - Prefernces Values
    @State var darkModeToggle: Bool = UserDefaults.standard.isDarkModeEnabled
    @State var language: Language = UserDefaults.standard.currentLanguage
    
    // MARK: - Initial Actions
    var didPressLogout: ()->()
    var didChangeLanguage: (Language)->()
    
    // MARK: - View
    var body: some View {
        Form {
            Section("Preferences"~) {
                Toggle("Enable Dark Mode"~, isOn: $darkModeToggle)
                    .onChange(of: darkModeToggle) { newValue in
                        UserDefaults.standard.isDarkModeEnabled = newValue
                        guard let scene = UIApplication.shared.connectedScenes.first else { return }
                        let window = (scene.delegate as! SceneDelegate).window
                        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve) {
                            window?.backgroundColor = UserDefaults.standard.isDarkModeEnabled ? .black : .white
                            window?.overrideUserInterfaceStyle = UserDefaults.standard.isDarkModeEnabled ? .dark : .light
                        }
                    }
                HStack {
                    Text("Language"~)
                    Spacer()
                    Picker("Language"~, selection: $language) {
                        ForEach(Language.allCases) { language in
                            Text(language.rawValue).tag(language)
                        }
                    }
                    .pickerStyle(.menu)
                        .onChange(of: language) { newValue in
                            didChangeLanguage(newValue)
                        }
                }
            }
            
            Section("Account"~) {
                Button("Logout"~) {
                    didPressLogout()
                }.foregroundColor(.red)
            }
            
            Section("Developer"~) {
                Button("Visit Repository.."~) {
                    UIApplication.shared.open(URL(string: "https://github.com/ahmedfathy-m/Tweetarium")!)
                }
                Button("Follow Me on LinkedIn"~) {
                    UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/ahmedfathy-mha/")!)
                }
                Button("Follow Me on Github"~) {
                    UIApplication.shared.open(URL(string: "https://github.com/ahmedfathy-m")!)
                }
            }
        }
        .environment(\.layoutDirection, language == .arabic ? .rightToLeft : .leftToRight)
        
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences {
            
        } didChangeLanguage: { _ in 
            
        }
    }
}
