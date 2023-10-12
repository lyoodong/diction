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
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

    }
    
    lazy var sortByOldButton = UIButton().then {
        $0.setTitle("오래된순", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

    }
    
    lazy var sortByNewButton = UIButton().then {
        $0.setTitle("최근순", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .mainBlue
    }
    
    override func configure() {
        self.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.backgroundColor = .white
    }
    
    override func layouts() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
    
        let height = UIScreen.main.bounds.height / 16
        
        addSubview(sortByLevelButton)
        
        sortByLevelButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(Constant.spacing * 2)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        addSubview(sortByOldButton)
        
        sortByOldButton.snp.makeConstraints {
            $0.top.equalTo(sortByLevelButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        addSubview(sortByNewButton)
        
        sortByNewButton.snp.makeConstraints {
            $0.top.equalTo(sortByOldButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(sortByNewButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
