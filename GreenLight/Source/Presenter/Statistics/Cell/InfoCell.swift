//
//  InfoCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import UIKit

class InfoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.addShadow()
    }
    
    func layouts() {
    }
}


