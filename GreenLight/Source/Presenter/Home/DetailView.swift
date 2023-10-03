//
//  DetailView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/03.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    
    lazy var recordButton = UIButton().then {
        let defaultImage = UIImage(systemName: "mic.fill")
        let selectedImage = UIImage(named: "pause.circle")
        $0.setImage(defaultImage, for: .normal)
        $0.setImage(selectedImage, for: .selected)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.tintColor = .gray
    }
    
    lazy var cancelButton = UIButton().then {
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.red, for: .normal)
    }
    
    lazy var saveButton = UIButton().then {
        let image = UIImage(systemName: "stop.circle")
        image?.withTintColor(.black)
        $0.setImage(image, for: .normal)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.tintColor = .gray
    }
    
    lazy var recordStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 50
        $0.addArrangedSubview(cancelButton)
        $0.addArrangedSubview(recordButton)
        $0.addArrangedSubview(saveButton)
    }
    
    lazy var resultTextView = UITextView().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 10
    }
    
    lazy var timeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = UIFont.systemFont(ofSize: 32)
    }
    
    override func viewSet() {
        addSubView()
        self.backgroundColor = .white
    }
    
    func addSubView() {
        [recordStackView, timeLabel, resultTextView].forEach(addSubview)
    }
    
    override func constraints() {
        
        cancelButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        recordButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(300)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(resultTextView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}
