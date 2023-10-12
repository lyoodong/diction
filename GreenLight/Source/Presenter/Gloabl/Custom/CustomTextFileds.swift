//
//  CustomTextFileds.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit
import SkyFloatingLabelTextField
import SnapKit
import Then

class CustomTextFields: BaseView {
    
    lazy var textFields = SkyFloatingLabelTextField().then {
        $0.selectedTitleColor = .mainBlue!
        $0.selectedLineColor = .mainBlue!
    }
    
    override func layouts() {
        addSubview(textFields)

        textFields.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
