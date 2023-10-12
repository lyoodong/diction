//
//  File.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit

class CollectionViewLayouts {

    static func baseCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 5
        let height = width * 0.4
        let inset = UIEdgeInsets(top: Constant.spacing * 2, left: 0, bottom: 0, right: 0)
        let layout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.minimumInteritemSpacing =  Constant.spacing * 2
        layout.sectionInset = inset
        
        return layout
    }
    
    static func replyCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 5
        let height = width * 0.27
        let inset = UIEdgeInsets(top: Constant.spacing * 2, left: 0, bottom: 0, right: 0)
        let layout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.minimumInteritemSpacing =  Constant.spacing * 2
        layout.sectionInset = inset
        
        return layout
    }
    
}
