//
//  Ext+UIImage.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit

extension UIImage {
    convenience init?(resource: Constant.Image) {
        self.init(systemName: resource.rawValue)
    }
    
    convenience init?(assetName: Constant.Image) {
        self.init(named: assetName.rawValue)
    }
}
