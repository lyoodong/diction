//
//  QuestionView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit

final class QuestionView: BaseView {
    lazy var questionCollectionView = BaseCollectionView()
    
    lazy var sortButton = UIButton().then {
        $0.setTitle("정렬 v", for: .normal)
    }
    
    override func viewSet() {
        self.backgroundColor = .bgGrey
        addSubView()
    }
    
    private func addSubView() {
        [sortButton, questionCollectionView].forEach(addSubview)
    }

    override func constraints() {
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(Constant.spacing)
            
        }
        
        questionCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}
