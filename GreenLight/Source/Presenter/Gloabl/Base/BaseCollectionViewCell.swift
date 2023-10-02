//
//  BaseCollectionViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit
import SnapKit
import Then

class BaseCollectionViewCell: UICollectionViewCell {
    
    lazy var cellTitleLabel = UILabel().then {
        $0.text = "새싹 5기 면접 질문"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    lazy var levelStatusImageView = UIImageView().then {
        $0.image = UIImage(named: "lowLevel")
    }
    
    lazy var levelStatusLabel = UILabel().then {
        $0.text = "연습 필요"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var levelStatusStackView = UIStackView().then {
        $0.backgroundColor = .tabBarGrey
        $0.spacing = 4
        $0.addArrangedSubview(levelStatusImageView)
        $0.addArrangedSubview(levelStatusLabel)
    }
    
    lazy var interviewDateCntButton = UIButton().then {
        $0.setTitle("  D - 25  ", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.setTitleColor(.mainBlue, for: .normal)
        $0.backgroundColor = .tabBarGrey
        $0.layer.cornerRadius = 6
    }
    
    lazy var interviewDateLabel = UILabel().then {
        $0.text = "면접일 2023.09.20 목 |"
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var questionCntLabel = UILabel().then {
        $0.text = "11개"
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var interviewStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.spacing = 4
        $0.addArrangedSubview(interviewDateCntButton)
        $0.addArrangedSubview(interviewDateLabel)
        $0.addArrangedSubview(questionCntLabel)
    }
    
    lazy var editButton = UIButton().then {
        let image = UIImage(named: "Edit_fill")
        $0.setImage(image, for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSet()
        constraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewSet() {
        self.backgroundColor = .mainWhite
        addSubView()
        self.layer.cornerRadius = 12
        
    }
    
    func addSubView() {
        [cellTitleLabel, levelStatusStackView, interviewStackView].forEach(addSubview)
    }
    
    func constraints() {
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        levelStatusStackView.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        interviewStackView.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 3)
        }
    }
    
}

