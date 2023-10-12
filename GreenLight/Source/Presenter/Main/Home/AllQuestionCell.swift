//
//  AllQuestionCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/10.
//

import UIKit
import SnapKit

class AllQuestionCell: UICollectionViewCell {
    
    lazy var cellTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.text = "전체 질문을 조회"
    }
    
    lazy var interviewDateLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var questionCntLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var interviewStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.spacing = 6
        $0.addArrangedSubview(interviewDateLabel)
        $0.addArrangedSubview(questionCntLabel)
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
        self.backgroundColor = .mainBlue
        self.layer.cornerRadius = 12
    }
    
    func constraints() {
        
        contentView.addSubview(cellTitleLabel)
                 
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        contentView.addSubview(cellTitleLabel)
        
        interviewStackView.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 3)
        }
    
    }
}
