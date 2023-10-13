//
//  DetailReplyViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit
import SnapKit
import RealmSwift

class DetailReplyViewController: BaseViewController {
    
    let detailReplyView = DetailReplyView()
    let vm = DetailReplyViewModel()

    override func loadView() {
        view = detailReplyView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.setRealm()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateMemo()
    }
    
    override func configure() {
        vm.setRealm()
        setViewData()
        setNavigationItem()
        setCollectionView()
        addTarget()
    }
}

extension DetailReplyViewController {
    private func setNavigationItem() {
        navigationItem.title = vm.question.first?.questionTitle
        navigationItem.backButtonTitle = ""
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
    }
}

extension DetailReplyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        detailReplyView.replyListCollectionView.delegate = self
        detailReplyView.replyListCollectionView.dataSource = self
        detailReplyView.replyListCollectionView.register(DetailReplyCollectioViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.fetchAnswersCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DetailReplyCollectioViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setDetailReplyCollectioViewCell(answers: vm.answers, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
                let vc = DetailViewController()
                let row = indexPath.row
                vc.vm.answerID = self.vm.answers[row].answerID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension DetailReplyViewController {
    
    func addTarget() {
        detailReplyView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func addButtonTapped() {
        let vc = RecordViewController()
        vc.vm.questionID = vm.questionID
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension DetailReplyViewController {
    
    func setViewData() {
        detailReplyView.limitTimeLabel.text = vm.fetchLimitTime()
        detailReplyView.customTextView.resultTextView.text = vm.fetchMemoText()
        detailReplyView.interviewDateLabel.text = vm.fetchCreationDate()
        
        detailReplyView.customLevelStackView.levelStatusImageView.image = returnLightImage(familiarityDegree: vm.fetchFamiliartyDegree())
    }
    
    func updateMemo() {
        vm.memoText = detailReplyView.customTextView.resultTextView.text
        vm.updateMemoText()
    }
}
