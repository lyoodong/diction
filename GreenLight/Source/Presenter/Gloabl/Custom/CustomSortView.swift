//
//  CustomSortViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit
import Then

class CustomSortView: BaseView {
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .tabBarGrey
        $0.text = "정렬"
    
    }
    
    lazy var sortByLevelButton = UIButton().then {
        $0.setTitle("숙련도순", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.textAlignment = .left
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    lazy var sortByOldButton = UIButton().then {
        $0.setTitle("오래된순", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.textAlignment = .left
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    lazy var sortByNewButton = UIButton().then {
        $0.setTitle("최근순", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.textAlignment = .left
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override func viewSet() {
        self.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.backgroundColor = .white
        addSubView()
    }
    
    func addSubView() {
        [titleLabel, sortByLevelButton, sortByOldButton, sortByNewButton].forEach(addSubview)
    }
    
    override func constraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
        sortByLevelButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
        sortByOldButton.snp.makeConstraints {
            $0.top.equalTo(sortByLevelButton.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
        sortByNewButton.snp.makeConstraints {
            $0.top.equalTo(sortByOldButton.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
    }
    
}
