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
    
    lazy var homeCollectionView = BaseCollectionView()
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("정렬 v", for: .normal)
    }
    
    override func viewSet() {
        self.backgroundColor = .mainBlue
        addSubView()
    }
    
    private func addSubView() {
        [sortButton, homeCollectionView].forEach(addSubview)
    }

    override func constraints() {
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing * 3)
            
        }
        homeCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}

