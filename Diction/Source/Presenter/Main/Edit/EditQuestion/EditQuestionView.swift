//
//  EditQuestionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit
import Then

class EditQuestionView: BaseView {
    lazy var questionTitleTextFields = CustomTextFields().then {
        $0.textFields.placeholderFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textFields.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textFields.backgroundColor = .bgGrey
        $0.textFields.placeholder = "질문 이름을 입력해주세요."
        $0.textFields.title = "질문 이름"
    }
    
    lazy var questionLevelTitle = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "나의 숙련도"
    }
    
    lazy var redLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "red_unselected"), for: .normal)
        $0.setImage(UIImage(named: "red_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var ornageLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "orange_unselected"), for: .normal)
        $0.setImage(UIImage(named: "orange_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var blueLevelButton = UIButton().then {
        $0.setImage(UIImage(named: "blue_unselected"), for: .normal)
        $0.setImage(UIImage(named: "blue_selected"), for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    lazy var buttonStackView = UIStackView().then {
        $0.spacing = Constant.spacing
        $0.addArrangedSubview(redLevelButton)
        $0.addArrangedSubview(ornageLevelButton)
        $0.addArrangedSubview(blueLevelButton)
    }
    
    lazy var limitTimeTextFields = CustomTextFields().then {
        $0.textFields.placeholderFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textFields.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textFields.backgroundColor = .bgGrey
        $0.textFields.placeholder = "제한 시간을 입력해주세요."
        $0.textFields.title = "제한 시간"
        $0.textFields.inputAccessoryView = limitTimePickerView
    }
    
    lazy var limitTimePickerView = UIPickerView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    lazy var folderTitle = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "폴더"
    }

    lazy var folderSelectCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.folderSelectCollectionViewFlowLayout())
    
    lazy var addButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitle("저장", for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .mainBlue
        $0.addShadow()
    }
    
    override func layouts() {
        
        let width = UIScreen.main.bounds.width - 48
        
        addSubview(questionTitleTextFields)
        
        questionTitleTextFields.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(questionLevelTitle)
        
        questionLevelTitle.snp.makeConstraints {
            $0.top.equalTo(questionTitleTextFields.snp.bottom).offset(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        [redLevelButton, ornageLevelButton, blueLevelButton].forEach { UIButton in
            UIButton.snp.makeConstraints {
                $0.width.equalTo(85)
                $0.height.equalTo(28)
            }
        }
        
        addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints {
            $0.centerY.equalTo(questionLevelTitle)
            $0.leading.equalTo(questionLevelTitle.snp.trailing).offset(Constant.spacing)
        }
        
        addSubview(limitTimeTextFields)
        
        limitTimeTextFields.snp.makeConstraints {
            $0.top.equalTo(questionLevelTitle.snp.bottom).offset(Constant.spacing * 2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(folderTitle)
        
        folderTitle.snp.makeConstraints {
            $0.top.equalTo(limitTimeTextFields.snp.bottom).offset(Constant.spacing * 3)
            $0.leading.equalTo(Constant.spacing * 3)
        }
        
        addSubview(folderSelectCollectionView)
        addSubview(addButton)
        
        folderSelectCollectionView.snp.makeConstraints {
            $0.top.equalTo(folderTitle.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(addButton.snp.top)
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(width * 0.13)
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-Constant.spacing * 2)
        }
    }
}


