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
        $0.text = "\(Date()) + 0분 0초"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var replyContainerStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 4
//        $0.addArrangedSubview(interviewDateLabel)
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
    
    let recordAnimation = LottieAnimation.named("blueMic")
    
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
        $0.setImage(image, for: .normal)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.tintColor = .mainBlue
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
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 12
        $0.addShadow()
    }
    
    lazy var resultTextView = UITextView().then {
        let range = NSMakeRange($0.text.count - 1, 0)
        $0.scrollRangeToVisible(range)
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = UIFont.systemFont(ofSize: 18, weight: .light)
        $0.addShadow()
        $0.clipsToBounds = false
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
    }
    
    lazy var redLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "red_unselected"), for: .normal)
        $0.setImage(UIImage(named: "red_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var ornageLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "orange_unselected"), for: .normal)
        $0.setImage(UIImage(named: "orange_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var blueLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "blue_unselected"), for: .normal)
        $0.setImage(UIImage(named: "blue_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var levelButtonStackView = UIStackView().then {
        $0.spacing = Constant.spacing
        $0.addArrangedSubview(redLevelButton)
        $0.addArrangedSubview(ornageLevelButton)
        $0.addArrangedSubview(blueLevelButton)
    }
    
    lazy var timeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textColor = .textDarkGrey
    }

    override func configure() {
        self.backgroundColor = .white
    }
    
    
    
    override func layouts() {
        
        cancelButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        recordButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
            
        let width = UIScreen.main.bounds.width - 32
            
        self.addSubview(replyContainerStackView)
        
        replyContainerStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 2)
        }
        
        self.addSubview(customLevelStackView)

        customLevelStackView.snp.makeConstraints {
            $0.top.equalTo(replyContainerStackView.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing + 4)
        }
        
        self.addSubview(recordedReplyLabel)
        
        recordedReplyLabel.snp.makeConstraints {
            $0.top.equalTo(customLevelStackView.snp.bottom).offset(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 2)
        }
        
        self.addSubview(resultTextView)
        self.addSubview(container)
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(recordedReplyLabel.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.container.snp.top).offset( -Constant.spacing * 2)
        }
        
//        [redLevelButton, ornageLevelButton, blueLevelButton].forEach { UIButton in
//            UIButton.snp.makeConstraints {
//                $0.width.equalTo(85)
//                $0.height.equalTo(28)
//            }
//        }
//
//        addSubview(levelButtonStackView)
        
//        levelButtonStackView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(resultTextView.snp.bottom).offset(16)
//        }

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
            $0.size.equalTo(130)
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(Constant.spacing * 5)
            $0.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(container.snp.top).offset(Constant.spacing * 1)
            $0.centerX.equalTo(recordButton.snp.centerX)
        }
    }
}
