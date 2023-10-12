//
//  replyListCollectioViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit
import SnapKit
import Then

class ReplyListCollectioViewCell: UICollectionViewCell {
    
    lazy var micButton = UIButton().then {
        $0.setImage(UIImage(resource: .mic), for: .normal)
        $0.tintColor = .black
    }

    
    lazy var cellTitleLabel = UILabel().then {
        $0.text = "새싹 5기 면접 질문"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    lazy var replyTextLabel = UILabel().then {
        $0.text = "안녕하세요. 저는 조혜원입니다."
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    lazy var createdDateLabel = UILabel().then {
        $0.text = "2023.09.20 목 |"
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var timeLabel = UILabel().then {
        $0.text = "00:13 초"
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var interviewStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.spacing = 4
        $0.addArrangedSubview(createdDateLabel)
        $0.addArrangedSubview(timeLabel)
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
        self.layer.cornerRadius = 12
    }
    
    func constraints() {
        
        addSubview(cellTitleLabel)
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 6)
            $0.trailing.equalTo(-Constant.spacing * 3)
        }
        
        addSubview(replyTextLabel)
        
        replyTextLabel.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 6)
            $0.trailing.equalTo(-Constant.spacing * 3)
        }
    
        addSubview(interviewStackView)

        interviewStackView.snp.makeConstraints {
            $0.top.equalTo(replyTextLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 6)
        }
        
        addSubview(micButton)
        
        micButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.leading.equalTo(Constant.spacing)
            $0.centerY.equalToSuperview()
        }
 
    }
    
}
