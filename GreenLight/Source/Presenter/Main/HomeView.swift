//
//  MainView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    lazy var homeCollectionView = BaseCollectionView()
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("Pull-Down 메뉴 버튼", for: .normal)
    }
    
    override func viewSet() {
        self.backgroundColor = .mainBlue
        addSubView()
    }
    
    func addSubView() {
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


//func sortButtonSet() {
//    let favorite = UIAction(title: "평점입력", image: UIImage(systemName: "star"), handler: { _ in print("평점입력") })
//    sortButton.menu = UIMenu(title: "타이틀",
//                         image: UIImage(systemName: "heart"),
//                         identifier: nil,
//                         options: .displayInline,
//                         children: [favorite])
//}
