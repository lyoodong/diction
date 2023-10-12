//
//  Observable.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/11.
//

import Foundation

class observable<T> {
    private var listener:((T)->Void)?
    
    var value: T{
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping (T)->Void) {
        completion(value)
        listener = completion
        
    }
}
