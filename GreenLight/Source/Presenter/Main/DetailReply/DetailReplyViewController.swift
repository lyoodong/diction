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
    
    var isFolded = false
    
    var resultTextViewHeightConstraint: Constraint?
    
    let repo = CRUDManager.shared
    var question: Results<QuestionModel>!
    var questionID = ObjectId()
    
    var answers: Results<AnswerModel>!
    
    override func loadView() {
        view = detailReplyView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
        let savedMemoText = question[0].questionMemoText
    
        detailReplyView.customTextView.resultTextView.text = savedMemoText
        answers = repo.filterByObjcID(object: AnswerModel.self, key: "questionID", objectID: questionID)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let result = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
        if let memoText = detailReplyView.customTextView.resultTextView.text {
            let realm = try! Realm()
            
            try! realm.write {
                result[0].questionMemoText = memoText
            }
        }
    }
    
    override func configure() {
        question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
        let savedMemoText = question[0].questionMemoText
    
        detailReplyView.customTextView.resultTextView.text = savedMemoText
        answers = repo.filterByObjcID(object: AnswerModel.self, key: "questionID", objectID: questionID)
        setNavigationItem()
        setCollectionView()
        addTarget()
        
        detailReplyView.limitTimeLabel.text = question.first?.limitTimeToString
        
        if let createdDate = question.first?.creationDate {
            detailReplyView.interviewDateLabel.text = createdDate.dateFormatter
        }
        
        if let familiarityDegree = question.first?.familiarityDegree {
            detailReplyView.customLevelStackView.levelStatusImageView.image = returnLightImage(familiarityDegree: familiarityDegree)
        }
        detailReplyView.addButton.addShadow()
        detailReplyView.customTextView.resultTextView.addShadow()
        
    }
    
    override func layouts() {
        
    }
    
}

extension DetailReplyViewController {
    private func setNavigationItem() {
        
        navigationItem.title = question.first?.questionTitle
        navigationItem.backButtonTitle = ""
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 26)]
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}

extension DetailReplyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        detailReplyView.replyListCollectioView.delegate = self
        detailReplyView.replyListCollectioView.dataSource = self
        detailReplyView.replyListCollectioView.register(ReplyListCollectioViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ReplyListCollectioViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        cell.cellTitleLabel.text = answers[row].creationDate.detailDateFormatter + "  녹음"
        cell.replyTextLabel.text = answers[row].recordText
        cell.createdDateLabel.text = "| "
//        answers[row].creationDate.dateFormatter
        cell.timeLabel.text = answers[row].answeringTimeToString
        cell.addShadow()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
                let vc = DetailViewController()
                let row = indexPath.row
                vc.answerID = self.answers[row].answerID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension DetailReplyViewController {
    
    func addTarget() {
        detailReplyView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        detailReplyView.customTextView.foldingButton.addTarget(self, action: #selector(foldingButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func addButtonTapped() {
        let vc = RecordViewController()
        
        vc.questionID = questionID
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func foldingButtonTapped() {
        
    }
    
}
