//
//  EditQuestionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit
import Then

class EditQuestionView: BaseView {
    
    
    lazy var title = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.text = "질문의 이름을 입력해주세요."
    }
    
    lazy var questionTitleTextFields = CustomTextFields()
    
    lazy var questionLevelTitle = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.text = "숙련도를 추가해주세요."
    }
    
    lazy var questionLevelEditButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.tintColor = .black
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var familiarDegreeTextFields = CustomTextFields()
    
    lazy var limitTimeTextFields = UITextField().then {
        $0.inputAccessoryView = limitTimePickerView
        $0.backgroundColor = .mainBlue
        $0.placeholder = "제한 시간을 입력해주세요."
    }
    
    lazy var limitTimePickerView = UIPickerView().then {
        $0.backgroundColor = .mainBlue
        $0.clipsToBounds = true
        $0.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }

    lazy var folderSelectCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.baseCollectionViewFlowLayout())
    
    override func layouts() {
        addSubview(title)
        
        title.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        let width = UIScreen.main.bounds.width - 48
        
        addSubview(questionTitleTextFields)
        
        questionTitleTextFields.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(title.snp.bottom)
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(questionLevelTitle)
        
        questionLevelTitle.snp.makeConstraints {
            $0.top.equalTo(questionTitleTextFields.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        addSubview(questionLevelEditButton)
        
        questionLevelEditButton.snp.makeConstraints {
            $0.top.equalTo(questionLevelTitle)
            $0.leading.equalTo(questionLevelTitle.snp.trailing).offset(Constant.spacing * 2)
            $0.size.equalTo(24)
        }
        
        addSubview(familiarDegreeTextFields)
        
        familiarDegreeTextFields.snp.makeConstraints {
            $0.top.equalTo(questionLevelTitle.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(limitTimeTextFields)
        
        limitTimeTextFields.snp.makeConstraints {
            $0.top.equalTo(familiarDegreeTextFields.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(folderSelectCollectionView)
        
        folderSelectCollectionView.snp.makeConstraints {
            $0.top.equalTo(limitTimeTextFields.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}


