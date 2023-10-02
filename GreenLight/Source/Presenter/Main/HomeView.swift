//
//  MainView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

class HomeView: BaseView {
    
    lazy var mainCollectionView = BaseCollectionView()
    
    override func viewSet() {
        self.backgroundColor = .mainBlue
        addSubView()
    }
    
    func addSubView() {
        [mainCollectionView].forEach(addSubview)
    }
    
    override func constraints() {
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.left.equalTo(self.safeAreaLayoutGuide)
            $0.right.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}
