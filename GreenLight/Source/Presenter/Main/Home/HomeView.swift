//
//  MainView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    lazy var navigationItem = UINavigationItem()
    
    lazy var homeCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.baseCollectionViewFlowLayout())
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("정렬", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    override func configure() {
        self.backgroundColor = .bgGrey
        addSubView()
    }
    
    private func addSubView() {
        [sortButton, homeCollectionView].forEach(addSubview)
    }

    override func layouts() {
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing * 3)
            
        }
        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}

