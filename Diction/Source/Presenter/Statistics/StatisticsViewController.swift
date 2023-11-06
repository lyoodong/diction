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
    private let statisticsView = StatisticsView()
    
    init(StatisticsViewModel: StatisticsViewModel) {
        self.StatisticsViewModel = StatisticsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = statisticsView
    }
    
    
    override func configure() {
        setStatisticsCollectionView()
        
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setStatisticsCollectionView() {
        statisticsView.statisticsCollectionView.delegate = self
        statisticsView.statisticsCollectionView.dataSource = self
        
        let cellIdentifiers = [
            TotalAswerTimeCell.IDF: TotalAswerTimeCell.self,
            WeeklyLearningRecordCell.IDF : WeeklyLearningRecordCell.self
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            statisticsView.statisticsCollectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch indexPath.row {
        case 0:
            let cell = statisticsView.statisticsCollectionView.dequeueReusableCell(withReuseIdentifier: TotalAswerTimeCell.IDF, for: indexPath) as! TotalAswerTimeCell
            
            let totalAnswerTime = StatisticsViewModel.fetchWeeklyAnsweringTime()
            cell.setCell(totalAnswerTime: totalAnswerTime)
    
            return cell
            
        case 1:
            let cell = statisticsView.statisticsCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyLearningRecordCell.IDF, for: indexPath) as! WeeklyLearningRecordCell
            
            let folderCount = StatisticsViewModel.fetchWeeklyModelCount(with: FolderModel.self)
            let questionCount = StatisticsViewModel.fetchWeeklyModelCount(with: QuestionModel.self)
            let answerCount = StatisticsViewModel.fetchWeeklyModelCount(with: AnswerModel.self)
            
            cell.setCell(folderCount: folderCount, questionCount: questionCount, answerCount: answerCount)
            
            return cell
            
      
        default:
            fatalError("Invalid cell index")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = LayoutSpacing()
        
        switch indexPath.item {
            
        case 0:
            return CGSize(width: spacing.width, height: spacing.width * 0.4)
        case 1:
            return CGSize(width: spacing.narrowedWidth(3), height: spacing.width * 0.5)
        
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}


