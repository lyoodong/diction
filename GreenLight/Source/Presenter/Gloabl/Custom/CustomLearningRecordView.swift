//
//  CustomLearningRecordView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/28.
//

import UIKit
import Lottie

class CustomLearningRecordView: BaseView {
    
    let animationName:String
    let learningRecordTitle: String
    
    lazy var learningAnimation = LottieAnimation.named("\(animationName)")
    
    lazy var learningAnimationView: LottieAnimationView = LottieAnimationView(animation: learningAnimation).then {
        $0.loopMode = .playOnce
    }
    
    lazy var learningRecordCntLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    lazy var learningRecordTitleLabel: UILabel = UILabel().then {
        $0.text = learningRecordTitle
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    lazy var containerStackView:UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubview(learningAnimationView)
        $0.addArrangedSubview(learningRecordCntLabel)
        $0.addArrangedSubview(learningRecordTitleLabel)
    }
    
    init( animationName: String, learningRecordTitle: String) {
        self.animationName = animationName
        self.learningRecordTitle = learningRecordTitle
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.backgroundColor = .clear
    }
    
    override func layouts() {
        
        let spacing = LayoutSpacing()
        
        learningAnimationView.snp.makeConstraints {
            $0.width.equalTo(spacing.multipleSpacing(6))
            $0.height.equalTo(spacing.multipleSpacing(8))
        }
        
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
