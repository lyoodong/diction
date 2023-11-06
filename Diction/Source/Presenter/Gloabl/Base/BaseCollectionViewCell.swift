//
//  BaseCollectionViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/27.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layout()
    }
    
    //실수로 일어날 수 있는 생성자 Call을 방지할 수 있다. -> 컴파일러가 에러 잡아냄
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
    func layout() {
        
    }
    
}
