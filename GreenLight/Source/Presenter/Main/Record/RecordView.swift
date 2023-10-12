//
//  DetailView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/03.
//

import UIKit
import SnapKit
import Lottie

class RecordView: BaseView {
    
    lazy var interviewDateLabel = UILabel().then {
        $0.text = "면접일 2023.09.20 목 | "
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var customLevelStackView = CustomLevelStackView()
    
    lazy var limitTimeLabel = UILabel().then {
        $0.text = "2분"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var replyContainerStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 4
        $0.addArrangedSubview(interviewDateLabel)
        $0.addArrangedSubview(limitTimeLabel)
    }
    
    lazy var recordedReplyLabel = UILabel().then {
        $0.text = "기록된 응답"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var recordButton = UIButton().then {
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.tintColor = .mainBlue
        $0.addShadow()
    }
    
    let recordAnimation = LottieAnimation.named("mic")
    
    lazy var recordAnimationView = LottieAnimationView(animation: recordAnimation).then {
        $0.loopMode = .loop
    }
    
    lazy var cancelButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.textDarkGrey, for: .normal)
    }
    
    lazy var saveButton = UIButton().then {
        let image = UIImage(systemName: "stop.circle")
        image?.withTintColor(.black)
        $0.setImage(image, for: .normal)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.tintColor = .red
    }
    
    lazy var recordStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 50
        $0.addArrangedSubview(cancelButton)
        $0.addArrangedSubview(recordButton)
        $0.addArrangedSubview(saveButton)
    }
    
    lazy var container = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.addShadow()
    }
    
    lazy var resultTextView = UITextView().then {
        let range = NSMakeRange($0.text.count - 1, 0)
        $0.scrollRangeToVisible(range)
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.layer.cornerRadius = 10
    }
    
    lazy var timeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .textDarkGrey
    }

    override func configure() {
        super.configure()
    }
    
    
    
    override func layouts() {
        
        cancelButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        recordButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        saveButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
            
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
        
        self.addSubview(resultTextView)
        self.addSubview(container)
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(recordedReplyLabel.snp.bottom).inset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.container.snp.top).offset( -Constant.spacing * 2)
        }

        container.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset( -Constant.spacing * 2)
            $0.width.equalTo(width)
            $0.height.equalTo(150)
        }
        
        container.addSubview(timeLabel)

        
        container.addSubview(recordAnimationView)
        container.addSubview(recordStackView)
        
        recordAnimationView.snp.makeConstraints {
            $0.centerX.equalTo(recordButton.snp.centerX)
            $0.centerY.equalTo(recordStackView)
            $0.size.equalTo(100)
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(Constant.spacing * 3)
            $0.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(container.snp.top).offset(Constant.spacing * 3)
            $0.centerX.equalTo(recordButton.snp.centerX)
        }
    }
}
