//
//  QuestionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit

final class QuestionView: BaseView {
    
    lazy var questionCollectionView = BaseCollectionView(collectionViewLayout: CollectionViewLayouts.baseCollectionViewFlowLayout())
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("정렬", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    lazy var emptyText: UILabel = UILabel().then {
        $0.text = "질문을 생성해주세요!"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    override func configure() {
        super.configure()
    }

    override func layouts() {
        
        addSubview(sortButton)
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing * 3)
        }
        
        addSubview(questionCollectionView)
        
        questionCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        addSubview(emptyText)
        
        emptyText.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
