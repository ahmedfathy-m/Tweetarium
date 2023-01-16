//
//  Observable.swift
//  Tweetarium
//
//  Created by Ahmed Fathy on 27/12/2022.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(self.value)
        self.listener = listener
    }
}
