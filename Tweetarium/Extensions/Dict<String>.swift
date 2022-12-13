//
//  Dict<String>.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 26/11/2022.
//

import Foundation
import UIKit

extension Dictionary where Key == String, Value == String {
    func toQueryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        self.forEach { key, value in
            items.append(URLQueryItem(name: key, value: value))
        }
        return items
    }
}
