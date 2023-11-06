//
//  FolderSelectCollectionCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/15.
//

import UIKit
import SnapKit
import RealmSwift

class FolderSelectCollectionCell: UICollectionViewCell {
    
    lazy var containerView = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.4)
    }
    
    lazy var cellTitleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    lazy var interviewDateCntButton = UIButton().then {
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.setTitleColor(.mainBlue, for: .normal)
        $0.backgroundColor = .bgGrey
        $0.layer.cornerRadius = 6
    }
    
    lazy var interviewDateLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.backgroundColor = .clear
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var questionCntLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var interviewStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.spacing = 6
        $0.addArrangedSubview(interviewDateCntButton)
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
        self.backgroundColor = .mainWhite
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
        addSubView()
    }
    
    func addSubView() {
         [cellTitleLabel, interviewStackView, containerView].forEach(addSubview)
    }
    
    func constraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        interviewDateCntButton.snp.makeConstraints {
            $0.height.equalTo(Constant.spacing * 3)
        }
        
        interviewStackView.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing )
            $0.leading.equalTo(Constant.spacing * 3)
        }
    }
    
    func setFolderSelectCollectionCell(folders:Results<FolderModel>, indexPath: IndexPath, selectedIndex: [Int] ) {
        
        cellTitleLabel.text = folders[indexPath.row].folderTitle
        interviewDateLabel.text = "면접일 " + folders[indexPath.row].interviewDate.dateFormatter + " | "
        interviewDateCntButton.setTitle("  \(folders[indexPath.row].interviewDate.cntDday)  ", for: .normal)
        
                
        questionCntLabel.text = "\(folders[indexPath.row].questions.count)개의 질문"
        
        if selectedIndex.contains(indexPath.row) {
            containerView.backgroundColor = .clear
            layer.borderColor = UIColor.mainBlue?.cgColor
            
        } else {
            containerView.backgroundColor = .white.withAlphaComponent(0.4)
            layer.borderColor = UIColor.systemGray3.cgColor
        }
        
    }
}
