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
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func returnLightImage(familiarityDegree:Int) -> UIImage? {
        switch familiarityDegree {
        case 0..<5:
            return UIImage(named: "RedLight")
        case 5..<7:
            return UIImage(named: "YellowLight")
        case 7...9 :
            return UIImage(named: "GreenLight")
        default:
            return UIImage(named: "RedLight")
        }
    }
}


