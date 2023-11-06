//
//  LayoutSpacing.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/27.
//

import UIKit

class LayoutSpacing {
    var width: CGFloat = UIScreen.main.bounds.width
    var heigt: CGFloat = UIScreen.main.bounds.height
    
    private let  spacing: CGFloat = 8
    
    func multipleSpacing(_ multipeOf: CGFloat) -> CGFloat {
        return multipeOf * spacing
    }
    
    func narrowedWidth(_ spacing: CGFloat) -> CGFloat {
        return width - multipleSpacing(spacing) * 2
    }
}

