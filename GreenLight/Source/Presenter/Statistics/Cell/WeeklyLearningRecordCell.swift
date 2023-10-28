//
//  WeeklyLearningRecordCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import UIKit

class WeeklyLearningRecordCell: BaseCollectionViewCell {
    
    lazy var TitleLabel: UILabel = UILabel().then {
        $0.text = "주간 학습 기록"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    lazy var folderCountView = CustomLearningRecordView(animationName: "folderAnimation", learningRecordTitle:"폴더").then {
        $0.learningAnimationView.play()
    }
    
    lazy var questionCountView = CustomLearningRecordView(animationName: "questionAnimation", learningRecordTitle:"질문").then {
        $0.learningAnimationView.play()
    }
    
    lazy var answerCountView = CustomLearningRecordView(animationName: "answerAnimation", learningRecordTitle:"응답").then {
        $0.learningAnimationView.play()
    }
    
    lazy var containerStackView: UIStackView = UIStackView().then {
        $0.spacing = 48
        $0.alignment = .center
        $0.addArrangedSubview(folderCountView)
        $0.addArrangedSubview(questionCountView)
        $0.addArrangedSubview(answerCountView)
    }
    
    override func configure() {
        backgroundColor = .white
        layer.cornerRadius = 16
        self.addShadow()
    }
    
    override func layout() {
        
        let spacing = LayoutSpacing()
        
        addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(spacing.multipleSpacing(2))
        }
        
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setCell(folderCount: Int, questionCount:Int, answerCount: Int ) {
        self.folderCountView.learningRecordCntLabel.text = "\(folderCount)"
        self.questionCountView.learningRecordCntLabel.text = "\(questionCount)"
        self.answerCountView.learningRecordCntLabel.text = "\(answerCount)"
    }
}


