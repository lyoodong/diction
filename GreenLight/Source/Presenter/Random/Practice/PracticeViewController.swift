//
//  PracticeViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/15.
//

import UIKit

class PracticeViewController: BaseViewController {
    
    var isSelected = false
    var indexPaths: [IndexPath] = []
    let practiceView = PracticeView()
    let vm = PracticeViewModel()
    
    override func loadView() {
        view = practiceView
    }
    
    override func configure() {
        vm.setRealm()
        setNavigationItem()
        setPracticeCollectionView()
        setViewData()
        addTarget()
    }
}


extension PracticeViewController {
    func setViewData() {
        vm.currnetQuestionIndex.bind { value in
            self.practiceView.currentIndexProgressBar.progress = self.vm.fetchProgress()
            self.practiceView.questionCountLabel.text = self.vm.fetchCurrentIndexTxt()
            self.vm.fetchCurrentFamilarDegree()
            self.vm.fetchLimitTime(index: value)
            self.setBackForwardButtons(value: value)
        }
        
        vm.limitTimeTxt.bind { value in
            self.practiceView.limitTimeLabel.text = value
        }
        
        vm.familarDegree.bind { value in
            if value == 3 {
                self.activeRedLevelButton(sender: self.practiceView.redLevelButton)
            } else if value == 6 {
                self.activeOrangeLevelButton(sender: self.practiceView.ornageLevelButton)
            } else {
                self.activeBlueLevelButton(sender: self.practiceView.blueLevelButton)
            }

            self.vm.uploadSelectedFamiliarityDegree(value: value)
        }
    }
    
    func setBackForwardButtons(value: Int) {
        if value == 0 {
            self.practiceView.backButton.backgroundColor = .white.withAlphaComponent(0.3)
            self.practiceView.backButton.isEnabled = false
        } else if value == self.vm.fetchQuestionCnt() - 1 {
            self.practiceView.forwardButton.backgroundColor = .white.withAlphaComponent(0.3)
            self.practiceView.forwardButton.isEnabled = false
        } else {
            self.practiceView.backButton.backgroundColor = .white
            self.practiceView.backButton.isEnabled = true
            self.practiceView.forwardButton.backgroundColor = .white
            self.practiceView.forwardButton.isEnabled = true
        }
    }
    
    func setlevelButtonUI() {
        vm.fetchCurrentFamilarDegree()
    }
    
    func addTarget() {
        practiceView.timerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        practiceView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        practiceView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        practiceView.redLevelButton.addTarget(self, action: #selector(redLevelButton), for: .touchUpInside)
        practiceView.ornageLevelButton.addTarget(self, action: #selector(ornageLevelButton), for: .touchUpInside)
        practiceView.blueLevelButton.addTarget(self, action: #selector(blueLevelButton), for: .touchUpInside)
    }
    
    @objc
    func timerButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        buttonClickAnimation(view: sender, ogBackgourdColor: .mainBlue!) {
            self.setTimer(isSelcted: sender.isSelected)
        }
        
        vm.currnetQuestionIndex.bind { value in
            self.indexPaths = [IndexPath(item: value, section: 0)]
            self.practiceView.practiceCollectionView.reloadItems(at: self.indexPaths)
        }
    }
    
    func setTimer(isSelcted: Bool) {
        isSelected = !isSelected
        if isSelected {
            self.vm.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.vm.limitTime.value -= 1
                self.vm.limitTimeTxt.value = self.vm.timeIntervalToString(timeInterval: self.vm.limitTime.value)
                
                if self.vm.limitTime.value == 0 {
                    timer.invalidate()
                }
            }
        } else {
            self.vm.timer?.invalidate()
            self.vm.timer = nil
        }
    }
    
    @objc
    func backButtonTapped(sender: UIButton) {
    }
    
    @objc
    func forwardButtonTapped() {
        
    }
    
    @objc
    func redLevelButton(sender: UIButton) {
        activeRedLevelButton(sender: sender)
        vm.familarDegree.value = 3
    }
    
    func activeRedLevelButton(sender:UIButton) {
        if !sender.isSelected {
            practiceView.ornageLevelButton.isSelected = false
            practiceView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @objc
    func ornageLevelButton(sender: UIButton) {
        activeOrangeLevelButton(sender: sender)
        vm.familarDegree.value = 6
    }
    
    func activeOrangeLevelButton(sender:UIButton) {
        if !sender.isSelected {
            practiceView.redLevelButton.isSelected = false
            practiceView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @objc
    func blueLevelButton(sender: UIButton) {
        activeBlueLevelButton(sender: sender)
        vm.familarDegree.value = 9
    }
    
    func activeBlueLevelButton(sender:UIButton) {
        if !sender.isSelected {
            practiceView.ornageLevelButton.isSelected = false
            practiceView.redLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    
    
}

extension PracticeViewController {
    private func setNavigationItem() {
        
        navigationItem.title = "폴더의 랜덤 질문"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
    
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainBlue
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
    
    }
}

extension PracticeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setPracticeCollectionView() {
        practiceView.practiceCollectionView.delegate = self
        practiceView.practiceCollectionView.dataSource = self
        practiceView.practiceCollectionView.register(PracticeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        practiceView.practiceCollectionView.isScrollEnabled = true
        practiceView.practiceCollectionView.isPagingEnabled = true
        practiceView.practiceCollectionView.showsHorizontalScrollIndicator = false
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.fetchQuestionCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PracticeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if practiceView.timerButton.isSelected {
            cell.cellTitleLabel.text = vm.fetchQuestionTitle(indexPath: indexPath)
        } else {
            cell.cellTitleLabel.text = "시작버튼을 눌러주세요🌱"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension PracticeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            vm.currnetQuestionIndex.value = Int(round(value))
        }
    }
}
