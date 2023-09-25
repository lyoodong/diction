//
//  Ext+UIView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit

extension UIView: ReturnIDF {
    static var IDF: String {
        return String(describing: self)
    }
}
