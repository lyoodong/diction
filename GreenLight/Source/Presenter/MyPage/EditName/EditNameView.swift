//
//  EditNameView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import UIKit
import SkyFloatingLabelTextField

class EditNameView: BaseView {

    lazy var eidtTextField: SkyFloatingLabelTextField = SkyFloatingLabelTextField().then {
        $0.placeholder = "변경할 닉네임을 입력해주세요"
        $0.selectedTitle = "변경할 닉네임"
        $0.errorColor = .systemRed
        $0.selectedTitleColor = .mainBlue!
        $0.selectedLineColor = .mainBlue!
        $0.errorMessagePlacement = .bottom
        $0.titleFadeOutDuration = 0.1
    }
    
    lazy var saveButton: UIButton = UIButton().then {
        let color = UIColor.mainBlue?.withAlphaComponent(0.7)
        $0.backgroundColor = color
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 10
        $0.addShadow()
        $0.isEnabled = false
    }
    
    override func configure() {
        backgroundColor = .white
    }
    
    override func layouts() {
        
        let width = UIScreen.main.bounds.width - 48
        let guide = self.safeAreaLayoutGuide
        let spacing = Constant.spacing
        
        addSubview(eidtTextField)
        eidtTextField.snp.makeConstraints {
            $0.top.equalTo(guide).offset(spacing * 3)
            $0.centerX.equalTo(guide)
            $0.width.equalTo(width)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.centerX.equalTo(guide)
            $0.width.equalTo(width)
            $0.height.equalTo(width / 7)
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-Constant.spacing * 2)
        }
    }

}

