//
//  RandomCollectionViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/13.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class RandomCollectionViewCell: UICollectionViewCell {
    
    lazy var cellTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
    }

    lazy var customLevelStackView = CustomLevelStackView().then {
        $0.spacing = 6
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
        self.backgroundColor = .mainWhite
        self.layer.cornerRadius = 12
        self.addShadow()
    }
    
    func layouts() {
        
        addSubview(cellTitleLabel)
        
        let width = self.bounds.width

        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 3)
            $0.width.equalTo(width - Constant.spacing * 3 )
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        addSubview(folderCntLabel)
        
        folderCntLabel.snp.makeConstraints {
            $0.leading.equalTo(Constant.spacing * 3)
            $0.bottom.equalToSuperview().offset(-Constant.spacing * 3)
        }
        
        addSubview(customLevelStackView)
        
        customLevelStackView.snp.makeConstraints {
            $0.leading.equalTo(Constant.spacing * 2)
            $0.bottom.equalTo(folderCntLabel.snp.top).offset(-Constant.spacing)
        }
    
    }
    
    func setRandomCollectioviewCell(folders: Results<FolderModel>, indexPath:IndexPath ) {
        cellTitleLabel.text = folders[indexPath.row].folderTitle
        folderCntLabel.text = "\(folders[indexPath.row].questions.count)개의 질문"
    }
}
