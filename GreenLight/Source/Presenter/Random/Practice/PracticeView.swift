//
//  PracticeView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/15.
//

import UIKit

class PracticeView: BaseView {
    
    lazy var questionCountLabel: UILabel = UILabel().then {
        $0.text = "1 / 3"
        $0.textColor = UIColor.mainBlue
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    lazy var currentIndexProgressBar: UIProgressView = UIProgressView().then {
        $0.progress = 0.6
        $0.progressTintColor = UIColor.mainBlue
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 7
        $0.subviews[1].clipsToBounds = true
        $0.backgroundColor = UIColor.bgGrey
    }
    
    
    lazy var questionCntStackView = UIStackView().then {
        $0.spacing = 6
        $0.addArrangedSubview(questionCountLabel)
        $0.addArrangedSubview(currentIndexProgressBar)
    }
    
    lazy var limitTimeLabel: UILabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = UIColor.textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 24)
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
    
    lazy var practiceCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.practiceCollectionViewFlowLayout()).then {
        $0.clipsToBounds = false
        $0.addShadow()
    }
    

    lazy var backButton: UIButton = UIButton().then {
        let image = UIImage(systemName: "chevron.backward")
        $0.setImage(image, for: .normal)
        $0.backgroundColor = .white
        $0.tintColor = .black
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
        $0.addShadow()
    }
    
    lazy var timerButton: UIButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        $0.setTitle("시작하기", for: .normal)
        $0.setTitle("중지하기", for: .selected)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = false
        $0.addShadow()
    }

    lazy var forwardButton: UIButton = UIButton().then {
        let image = UIImage(systemName: "chevron.forward")
        $0.setImage(image, for: .normal)
        $0.backgroundColor = .white
        $0.tintColor = .black
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = false
        $0.addShadow()
    }
    
    lazy var buttonStackView = UIStackView().then {
        $0.spacing = Constant.spacing * 2
        $0.addArrangedSubview(backButton)
        $0.addArrangedSubview(timerButton)
        $0.addArrangedSubview(forwardButton)
    }
    
    override func configure() {
        super.configure()
    }
    
    override func layouts() {
        
        let top = Constant.spacing * 2
        let leading = Constant.spacing * 3
        let width = UIScreen.main.bounds.width - leading * 2
        
        addSubview(questionCntStackView)
        questionCntStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(top)
            $0.leading.equalTo(leading)
            $0.height.equalTo(14)
        }
        
        currentIndexProgressBar.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(questionCntStackView.snp.height)
        }
        
        addSubview(practiceCollectionView)
        
        practiceCollectionView.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(practiceCollectionView.snp.width).multipliedBy(0.7)
        }
        
        addSubview(limitTimeLabel)
        
        limitTimeLabel.snp.makeConstraints {
            $0.top.equalTo(practiceCollectionView.snp.bottom).offset(top)
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        
        [redLevelButton, ornageLevelButton, blueLevelButton].forEach { UIButton in
            UIButton.snp.makeConstraints {
                $0.width.equalTo(85)
                $0.height.equalTo(28)
            }
        }
        
        addSubview(levelButtonStackView)
        
        levelButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(limitTimeLabel.snp.bottom).offset(top)
        }

        addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(levelButtonStackView.snp.bottom).offset(top * 2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        backButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        timerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(150)
        }
        
        forwardButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }
}
