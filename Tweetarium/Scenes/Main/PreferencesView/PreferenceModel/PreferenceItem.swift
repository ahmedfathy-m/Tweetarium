//
//  PreferenceItem.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 31/12/2022.
//

import Foundation

struct PreferenceItem {
    let name: String
    let key: String
//    let value: T
    let source: PreferenceSource
    let valueSource: ValueSource
}

struct ChildPreferenceItem {
    let name: String
    let key: String
}

enum PreferenceSource {
    case local
    case twitter
}

enum ValueSource {
    case switchable
    case submenu(children: [ChildPreferenceItem])
}
