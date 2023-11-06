//
//  MainView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import SnapKit
import Lottie

final class HomeView: BaseView {
    
    lazy var homeCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.baseCollectionViewFlowLayout())
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("정렬", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    lazy var emptyAnimation = LottieAnimation.named("savefolder")
    
    lazy var emptyAnimationView = LottieAnimationView(animation: emptyAnimation).then {
        $0.loopMode = .loop
    }
    
    lazy var emptyText: UILabel = UILabel().then {
        $0.text = "폴더를 생성해주세요!"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    override func configure() {
        super.configure()
    }

    override func layouts() {
    
        addSubview(sortButton)
    
        sortButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing * 3)
        }
        
        
        addSubview(homeCollectionView)

        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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

