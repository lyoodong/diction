//
//  Ext+UIViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit

extension UIViewController: ReturnIDF {
    static var IDF: String {
        return String(describing: self)
    }
}
