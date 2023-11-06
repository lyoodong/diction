//
//  CameraView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import UIKit
import AVFoundation
import Lottie

class CameraView: BaseView {
    
    lazy var testView: UIView = UIView().then {
        $0.backgroundColor = .bgGrey
    }
    
    lazy var questionCountLabel: UILabel = UILabel().then {
        $0.text = "1/3"
        $0.textColor = UIColor.textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 10)
    }
    
    lazy var cameraSwitchLabel: UILabel = UILabel().then {
        $0.text = "카메라"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    lazy var cameraSwitchButton: UISwitch = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .mainBlue
    }
    
    lazy var cameraSwitchStackView: UIStackView = UIStackView().then {
        $0.spacing = Constant.spacing
        $0.addArrangedSubview(cameraSwitchLabel)
        $0.addArrangedSubview(cameraSwitchButton)
    }
    
    lazy var emptyAnimation = LottieAnimation.named("camerOnOff")
    
    lazy var emptyAnimationView = LottieAnimationView(animation: emptyAnimation).then {
        $0.loopMode = .loop
        $0.play()
    }
    
    lazy var emptyText: UILabel = UILabel().then {
        $0.text = "카메라를 키면 내 모습을 볼 수 있어요!"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    lazy var questionCntStackView = UIStackView().then {
        $0.spacing = 6
        $0.addArrangedSubview(questionCountLabel)
        $0.addArrangedSubview(currentIndexProgressBar)
    }


    lazy var currentIndexProgressBar: UIProgressView = UIProgressView().then {
        $0.progress = 0.6
        $0.progressTintColor = UIColor.mainBlue
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 3
        $0.subviews[1].clipsToBounds = true
        $0.backgroundColor = UIColor.bgGrey
    }
    
    
    lazy var limitTimeLabel: UILabel = UILabel().then {
        $0.text = "00:00"
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
        $0.backgroundColor = .mainBlue!
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    lazy var questionView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = false
        $0.addShadow()
    }
    
    lazy var folderTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .textDarkGrey
        $0.text = "새싹5기 예상 면접질문"
    }
    
    lazy var questionTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.text = "트랜잭션이 무엇입니까?"
        $0.numberOfLines = 2
        $0.textAlignment = .center
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
    
    
    let recordAnimation = LottieAnimation.named("blueMic")
    
    lazy var recordAnimationView = LottieAnimationView(animation: recordAnimation).then {
        $0.loopMode = .loop
    }
    
    lazy var startButton: UIButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("이전", for: .normal)
        $0.setTitleColor(.textDarkGrey, for: .normal)
    }
    
    lazy var nextButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.textDarkGrey, for: .normal)
    }
    
    lazy var recordStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 60
        $0.addArrangedSubview(backButton)
        $0.addArrangedSubview(startButton)
        $0.addArrangedSubview(nextButton)
    }
    
    
    override func configure() {
        
    }
    
    override func layouts() {
        let spacing = Constant.spacing
        let guide = self.safeAreaLayoutGuide
        let width = UIScreen.main.bounds.width - spacing * 6
        let leading = spacing * 3
        
        addSubview(testView)
        testView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        testView.addSubview(emptyAnimationView)
        emptyAnimationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        testView.addSubview(emptyText)
        emptyText.snp.makeConstraints {
            $0.top.equalTo(emptyAnimationView.snp.bottom).offset(-Constant.spacing * 2)
            $0.centerX.equalToSuperview()
        }
    
        addSubview(limitTimeLabel)
        
        limitTimeLabel.snp.makeConstraints {
            $0.top.equalTo(guide).offset(spacing * 2)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(questionView)
        
        questionView.snp.makeConstraints {
            $0.top.equalTo(guide).offset(spacing * 2)
            $0.width.equalTo(width)
            $0.height.equalTo(width * 0.3)
            $0.centerX.equalToSuperview()
        }
        
        questionView.addSubview(folderTitleLabel)
        
        folderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(spacing)
            $0.centerX.equalToSuperview()
        }
        
        questionView.addSubview(questionTitleLabel)
        
        questionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(folderTitleLabel.snp.bottom).offset(spacing)
            $0.width.equalTo(width - (spacing * 2))
            $0.centerX.equalToSuperview()
        }
        
        [redLevelButton, ornageLevelButton, blueLevelButton].forEach { UIButton in
            UIButton.snp.makeConstraints {
                $0.width.equalTo(70)
                $0.height.equalTo(25)
            }
        }
        
        questionView.addSubview(levelButtonStackView)
        
        levelButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questionTitleLabel.snp.bottom).offset(spacing * 2)
        }
                
        addSubview(recordAnimationView)
        addSubview(recordStackView)
        
        recordAnimationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(recordStackView)
            $0.size.equalTo(130)
        }
        
    
        recordStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(guide).offset(-Constant.spacing * 5)
        }
        

        
        backButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        startButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        nextButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        addSubview(questionCntStackView)
        questionCntStackView.snp.makeConstraints {
            $0.bottom.equalTo(recordAnimationView.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        currentIndexProgressBar.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(questionCntStackView.snp.height)
        }
    }
}

//lazy var testView: UIImageView = UIImageView().then {
//        $0.image = UIImage(named: "person")
//    }

