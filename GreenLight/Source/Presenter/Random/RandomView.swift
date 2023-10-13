//
//  RandomView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/13.
//

import UIKit
import SnapKit

class RandomView: BaseView {
    
    lazy var randomCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.randomCollectionViewFlowLayout())
    
    override func configure() {
        
    }
    
    override func layouts() {
        
        addSubview(randomCollectionView)
        
        randomCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
