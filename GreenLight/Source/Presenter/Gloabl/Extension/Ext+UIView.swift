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

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.mainBlue?.cgColor
        layer.shadowOpacity = 0.11
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}


