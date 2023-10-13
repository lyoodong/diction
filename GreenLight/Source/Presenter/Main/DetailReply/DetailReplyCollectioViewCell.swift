//
//  replyListCollectioViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class DetailReplyCollectioViewCell: UICollectionViewCell {
    
    lazy var micButton = UIButton().then {
        $0.setImage(UIImage(resource: .mic), for: .normal)
        $0.tintColor = .black
    }

    lazy var cellTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    lazy var replyTextLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    lazy var createdDateLabel = UILabel().then {
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var timeLabel = UILabel().then {
        $0.textColor = .tabBarGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var interviewStackView = UIStackView().then {
        $0.spacing = 4
        $0.backgroundColor = .white
        $0.addArrangedSubview(createdDateLabel)
        $0.addArrangedSubview(timeLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        backgroundColor = .mainWhite
        layer.cornerRadius = 12
    }
    
    func layouts() {
        
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
    
    func setDetailReplyCollectioViewCell(answers: Results<AnswerModel>, indexPath: IndexPath ) {
        cellTitleLabel.text = answers[indexPath.row].creationDate.detailDateFormatter + "  녹음"
        replyTextLabel.text = answers[indexPath.row].recordText + "···"
        timeLabel.text = answers[indexPath.row].answeringTimeToString
        addShadow()
    }
}
