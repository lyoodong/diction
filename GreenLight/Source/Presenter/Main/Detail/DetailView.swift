//
//  DetailReplyView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/05.
//

import UIKit
import SnapKit
import Then

class DetailView: BaseView {
    
    lazy var interviewDateLabel = UILabel().then {
        $0.text = "면접일 2023.09.20 목 | "
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var limitTimeLabel = UILabel().then {
        $0.text = "2분"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var replyContainerStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 4
        $0.addArrangedSubview(interviewDateLabel)
//        $0.addArrangedSubview(limitTimeLabel)
    }
    
    lazy var recordedReplyLabel = UILabel().then {
        $0.text = "기록된 응답"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var resultTextView = UITextView().then {
        let range = NSMakeRange($0.text.count - 1, 0)
        $0.scrollRangeToVisible(range)
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    lazy var customLevelStackView = CustomLevelStackView()
    
    
    lazy var customPlayerView = CustomPlayerView().then {
        $0.setTitle(title: "응답 기록")
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.addShadow()
        
    }
    
    override func configure() {
        super.configure()
        layouts()
    }
    
    override func layouts() {
        
        let width = UIScreen.main.bounds.width - 32
        
        self.addSubview(replyContainerStackView)
        
        replyContainerStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        self.addSubview(customLevelStackView)
        
        customLevelStackView.snp.makeConstraints {
            $0.top.equalTo(replyContainerStackView.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        self.addSubview(recordedReplyLabel)
        
        recordedReplyLabel.snp.makeConstraints {
            $0.top.equalTo(customLevelStackView.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        self.addSubview(customPlayerView)
        
        customPlayerView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.width.equalTo(width)
            $0.height.equalTo(width * 0.5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing * 2)
        }
        
        self.addSubview(resultTextView)
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(recordedReplyLabel.snp.bottom).offset(Constant.spacing)
            $0.centerX.equalTo(self)
            $0.width.equalTo(width)
            $0.bottom.equalTo(customPlayerView.snp.top).offset(-Constant.spacing * 2)
        }
    }
}


