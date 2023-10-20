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
        let inset = UIEdgeInsets(top: Constant.spacing * 2, left: 0, bottom: Constant.spacing * 2, right: 0)
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
        let inset = UIEdgeInsets(top: Constant.spacing * 2, left: 0, bottom: Constant.spacing * 2, right: 0)
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.minimumInteritemSpacing =  Constant.spacing * 2
        layout.sectionInset = inset
        
        return layout
    }
    
    static func randomCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 10
        let height = width * 0.5
        let inset = UIEdgeInsets(top: Constant.spacing * 4, left: Constant.spacing * 4, bottom: Constant.spacing * 4, right: Constant.spacing * 4)
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: width / 2, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.sectionInset = inset
        
        return layout
    }
    
    static func folderSelectCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 5
        let height = width * 0.25
        let inset = UIEdgeInsets(top: Constant.spacing * 2, left: 0, bottom: Constant.spacing * 2, right: 0)
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.minimumInteritemSpacing =  Constant.spacing * 2
        layout.sectionInset = inset
        
        return layout
    }
    
    static func practiceCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 6
        let height = width * 0.7
        let layout = UICollectionViewFlowLayout()
        let spacing = Constant.spacing * 2
//        let inset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing =  0
        layout.scrollDirection = .horizontal
//        layout.sectionInset = inset

        return layout
    }
    
    
    
}
