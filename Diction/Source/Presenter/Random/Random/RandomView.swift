//
//  RandomView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/13.
//

import UIKit
import SnapKit
import Lottie

class RandomView: BaseView {
    
    lazy var randomCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.randomCollectionViewFlowLayout())
    
    lazy var emptyAnimation = LottieAnimation.named("savefolder")
    
    lazy var emptyAnimationView = LottieAnimationView(animation: emptyAnimation).then {
        $0.loopMode = .loop
    }
    
    lazy var emptyText: UILabel = UILabel().then {
        $0.text = "폴더에 질문을 추가해주세요!"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    override func configure() {
        
    }
    
    override func layouts() {
        
        addSubview(randomCollectionView)
        
        randomCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(emptyAnimationView)
        
        emptyAnimationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        addSubview(emptyText)
        
        emptyText.snp.makeConstraints {
            $0.top.equalTo(emptyAnimationView.snp.bottom).offset(Constant.spacing)
            $0.centerX.equalToSuperview()
        }
    }
}
