//
//  BaseColletionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import SnapKit

class BaseCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = baseCollectionViewFlowLayout()
        self.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.backgroundColor = .bgGrey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func baseCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width - Constant.spacing * 5
        let height = width * 0.4
        let layout = UICollectionViewFlowLayout()
    
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = Constant.spacing * 2
        layout.minimumInteritemSpacing =  Constant.spacing * 2
        
        return layout
    }
}



