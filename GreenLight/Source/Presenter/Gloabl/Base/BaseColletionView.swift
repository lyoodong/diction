//
//  BaseColletionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import SnapKit

class BaseCollectionView: UICollectionView {
    
    init(collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.backgroundColor = .bgGrey
        self.layer.cornerRadius = 18
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



