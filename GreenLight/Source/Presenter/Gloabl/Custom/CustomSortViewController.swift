//
//  CustomSortViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit
import SnapKit

class CustomSortViewController: BaseViewController {
    
    lazy var customSortView = CustomSortView()
    
    override func viewSet() {
        view.backgroundColor = .clear
        view.addSubview(customSortView)
    }
    
    override func constraints() {
        customSortView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height * 0.2)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }
    }
}
