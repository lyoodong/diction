//
//  EditFolderView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit
import SnapKit

class EditFolderView: BaseView {
    
    lazy var title = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.text = "폴더를 설정해주세요."
    }
    
    lazy var questionTitleTextFields = CustomTextFields().then {
        $0.textFields.placeholder = "폴더명을 입력해주세요."
        $0.textFields.title = "폴더명"
    }
    
    lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .inline
        $0.backgroundColor = .white
        $0.tintColor = .mainBlue
        $0.datePickerMode = .date
    }
    
    lazy var addButton = UIButton().then {
        $0.backgroundColor = .mainBlue
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitle("저장", for: .normal)
        $0.layer.cornerRadius = 10
    }
    
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
            $0.top.equalTo(title.snp.bottom).offset(Constant.spacing * 2)
            $0.height.equalTo(Constant.spacing * 7)
            $0.width.equalTo(width)
        }
        
        addSubview(datePicker)
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(questionTitleTextFields.snp.bottom).offset(Constant.spacing * 3)
            $0.width.equalTo(width)
            $0.height.equalTo(width)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(Constant.spacing * 3)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
        }
        
    }

}
