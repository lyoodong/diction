//
//  MyPageView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/18.
//

import UIKit

class MyPageView: BaseView {
    
    //    lazy var userNameLabel: UILabel = UILabel().then {
    //        $0.text = "류동완님의 정보"
    //        $0.font = UIFont.boldSystemFont(ofSize: 32)
    //    }
    //
    //    lazy var underLine: UIView = UIView().then {
    //        $0.backgroundColor = .white
    //    }
    
    lazy var myPageTableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .white
        $0.estimatedSectionHeaderHeight = 0
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    override func configure() {
        self.backgroundColor = .white
    }
    
    override func layouts() {
        
        let guide = self.safeAreaLayoutGuide
        
        addSubview(myPageTableView)
        
        myPageTableView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(guide)
            $0.top.equalToSuperview()
        }
    }
}
