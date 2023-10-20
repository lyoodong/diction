//
//  StatisticsViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import UIKit

class StatisticsViewController: BaseViewController {

    let statisticsView = StatisticsView()
    let vm = StatisticsViewModel()
    
    override func loadView() {
        view = statisticsView
    }
    
    override func configure() {
        setStatisticsCollectionView()
    }
}


//MARK: - setUI
extension StatisticsViewController {
    func setStatisticsCollectionView() {
        statisticsView.statisticsCollectionView.delegate = self
        statisticsView.statisticsCollectionView.dataSource = self
        
        let cellIdentifiers = [
            "CellIdentifier1": FamiliarityCell.self
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            statisticsView.statisticsCollectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        switch indexPath.item {
        case 0:
            cell = statisticsView.statisticsCollectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier1", for: indexPath) as! FamiliarityCell
    
            return cell
      
            
        default:
            fatalError("Invalid cell index")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing * 6
        
        switch indexPath.item {
            
        case 0:
            return CGSize(width: width, height: width)
        
        default:
            return CGSize(width: width, height: width)
        }
    }
    
    
    
}


