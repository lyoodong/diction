//
//  BaseCollectionViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
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
    
    lazy var customLevelStackView = CustomLevelStackView()
    
    lazy var interviewDateLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.textColor = .textDarkGrey
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
    
    lazy var editButton = UIButton().then {
        let size = CGSize(width: 18, height: 18)
        let rect = CGRect(origin: .zero, size: size)
        $0.imageRect(forContentRect: rect)
        let image = UIImage(named: "Edit")
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
        self.layer.cornerRadius = 12
        self.addShadow()
        addSubView()
    }
    
    func addSubView() {
        [cellTitleLabel, customLevelStackView, interviewStackView, editButton].forEach(addSubview)
    }
    
    func constraints() {
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        customLevelStackView.snp.makeConstraints {
            $0.top.equalTo(cellTitleLabel.snp.bottom).offset(Constant.spacing)
            $0.leading.equalTo(Constant.spacing * 2.5)
        }
        
        interviewDateCntButton.snp.makeConstraints {
            $0.height.equalTo(Constant.spacing * 3)
        }
        
        interviewStackView.snp.makeConstraints {
            $0.top.equalTo(customLevelStackView.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(Constant.spacing * 3)
            $0.trailing.equalTo(-Constant.spacing * 3)
            $0.size.equalTo(24)
        }
    }
    
    func setHomeCollectioviewCell(folders: Results<FolderModel>, indexPath:IndexPath ) {
        
        let folder = folders[indexPath.row]

        cellTitleLabel.text = folder.folderTitle
        interviewDateLabel.text = folder.interviewDate.dateFormatter + "  | "
        interviewDateCntButton.setTitle("  " + folder.interviewDate.cntDday + "  ", for: .normal)
        questionCntLabel.text = "\(folder.questions.count)개의 질문"
        customLevelStackView.levelStatusImageView.image = calculateAveregeDegree(questions: folder.questions)
    }
    
    func setQuestionCollectionViewCell(questions: Results<QuestionModel>, indexPath: IndexPath) {
        
        interviewDateCntButton.isHidden = true
        editButton.isHidden = true
        cellTitleLabel.text = questions[indexPath.row].questionTitle
        questionCntLabel.text = questions[indexPath.row].limitTimeToString
        interviewDateLabel.text = questions[indexPath.row].creationDate.dateFormatter + "  | "
        
        let familiarityDegree:Int = questions[indexPath.row].familiarityDegree
        if let lightImage = returnLightImage(familiarityDegree: familiarityDegree) {
            customLevelStackView.levelStatusImageView.image = lightImage
        }
    }

    func calculateAveregeDegree(questions: List<QuestionModel>) -> UIImage {
        var sum = 0
        for item in questions {
            sum += item.familiarityDegree
        }
        
        var result = 3
        if questions.count == 0 {

        } else {
            result = sum / questions.count
        }
        let lightImage = returnLightImage(familiarityDegree: result)

        guard let lightImage = lightImage else {
            return returnLightImage(familiarityDegree: 3)!
        }
        return lightImage
    }
}



