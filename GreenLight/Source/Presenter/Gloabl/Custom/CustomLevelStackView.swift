//
//  CustomLevelButton.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/05.
//

import UIKit

class CustomLevelStackView: UIStackView {
    
    let levelStatusImageView = UIImageView().then {
        $0.image = UIImage(named: "RedLight")
    }
    lazy var levelStatusLabel = UILabel().then {
        $0.text = "연습 필요"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSet()
        constraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewSet() {
        self.spacing = Constant.spacing
        self.layer.cornerRadius = 6
    }
    
    func constraints() {
        self.addArrangedSubview(levelStatusImageView)
        
        levelStatusImageView.snp.makeConstraints {
            $0.height.equalTo(Constant.spacing * 3)
            $0.width.equalTo(Constant.spacing * 7)
        }
        
        self.addArrangedSubview(levelStatusLabel)
    }
    
}
