//
//  StatisticsViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import UIKit

protocol StatisticsViewModelProtocol: AnyObject {
    var StatisticsViewModel: StatisticsViewModel { get }
}

class StatisticsViewController: BaseViewController, StatisticsViewModelProtocol {
    var StatisticsViewModel: StatisticsViewModel
    let statisticsView = StatisticsView()
    
    init(StatisticsViewModel: StatisticsViewModel) {
        self.StatisticsViewModel = StatisticsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = statisticsView
        setStatisticsCollectionView()
    }
    
    override func configure() {
        
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setStatisticsCollectionView() {
        statisticsView.statisticsCollectionView.delegate = self
        statisticsView.statisticsCollectionView.dataSource = self
        
        let cellIdentifiers = [
            InfoCell.IDF: InfoCell.self
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            statisticsView.statisticsCollectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch indexPath.row {
        case 0:
            let cell = statisticsView.statisticsCollectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.IDF, for: indexPath) as! InfoCell
    
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


