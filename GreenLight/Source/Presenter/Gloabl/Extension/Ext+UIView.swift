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
}
