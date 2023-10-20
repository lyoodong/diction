//
//  DetailReplyView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit
import SnapKit

class DetailReplyView: BaseView {
    
    lazy var interviewDateLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.backgroundColor = .clear
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var limitTimeLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var replyContainerStackView = UIStackView().then {
        $0.spacing = 4
        $0.backgroundColor = .clear
        $0.addArrangedSubview(interviewDateLabel)
        $0.addArrangedSubview(limitTimeLabel)
    }
    
    lazy var customLevelStackView = CustomLevelStackView()
    lazy var customTextView = CustomTextView(title: "메모")
    
    lazy var addButton = UIButton().then {
        $0.backgroundColor = .mainBlue
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitle("새로운 응답하기", for: .normal)
        $0.layer.cornerRadius = 10
        $0.addShadow()
    }
    
    lazy var lastReplyTitleLabel = UILabel().then {
        $0.text = "지난 응답 리스트"
        $0.font = UIFont.boldSystemFont(ofSize: 26)
    }
    
    lazy var replyListCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.replyCollectionViewFlowLayout())
    
    
    override func configure() {
        super.configure()
    }
    
    override func layouts() {
        
        addSubview(replyContainerStackView)
        
        replyContainerStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        addSubview(customLevelStackView)
        
        customLevelStackView.snp.makeConstraints {
            $0.top.equalTo(replyContainerStackView.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 2)
        }
        
        let width = UIScreen.main.bounds.width - 48
        
        addSubview(customTextView)
        
        customTextView.snp.makeConstraints {
            $0.top.equalTo(customLevelStackView.snp.bottom).offset(Constant.spacing)
            $0.centerX.equalTo(self)
            $0.width.equalTo(width)
            $0.height.equalTo(width * 0.4)
        }
        
        addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(customTextView.resultTextView.snp.bottom).offset(Constant.spacing)
            $0.centerX.equalTo(self)
            $0.width.equalTo(width)
            $0.height.equalTo(width * 0.15)
        }
        
        addSubview(lastReplyTitleLabel)
        
        lastReplyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(Constant.spacing * 5)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        addSubview(replyListCollectionView)
        
        replyListCollectionView.snp.makeConstraints {
            $0.top.equalTo(lastReplyTitleLabel.snp.bottom).offset(Constant.spacing * 2)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

