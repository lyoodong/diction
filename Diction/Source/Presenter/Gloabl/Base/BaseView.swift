//
//  BaseView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .bgGrey
    }
    
    func layouts() {
        
    }
}
