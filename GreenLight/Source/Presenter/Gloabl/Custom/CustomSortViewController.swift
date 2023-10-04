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
    private var tapGesture: UITapGestureRecognizer!
    
    override func viewSet() {
        view.addSubview(customSortView)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func constraints() {
        customSortView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height * 0.3)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
