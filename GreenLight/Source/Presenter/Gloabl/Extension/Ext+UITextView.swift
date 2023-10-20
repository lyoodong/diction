//
//  Ext+UITextView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import UIKit

extension UIViewController {
    func setLineAndLetterSpacing(_ attributedString: NSMutableAttributedString) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
//        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
//        self.attributedText = attributedString
        
        return attributedString
    }
}
