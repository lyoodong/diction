//
//  StatisticsView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import UIKit

class StatisticsView: BaseView {
    
    lazy var statisticsCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .bgGrey
    }
    
    override func layouts() {
        
        addSubview(statisticsCollectionView)
        statisticsCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
