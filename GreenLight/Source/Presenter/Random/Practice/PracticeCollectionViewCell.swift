//
//  PracticeCollectionViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/15.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class PracticeCollectionViewCell: UICollectionViewCell {
    
    lazy var cellTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
        $0.text = "예시 질문"
    }
    
    lazy var folderCntLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }

    lazy var editButton = UIButton().then {
        let image = UIImage(named: "Edit")
        $0.setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.addShadow()
    }
    
    func layouts() {
        
        addSubview(cellTitleLabel)
        
        let width = self.bounds.width

        cellTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
