//
//  QuestionViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit
import RealmSwift

final class QuestionViewController: BaseViewController {
    
    let questionView = QuestionView()
    let repo = CRUDManager.shared
    var questions: Results<QuestionModel>!
    var selectedFolder: Results<FolderModel>!
    var folderID: ObjectId = ObjectId()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
        
        questionView.questionCollectionView.reloadData()
    }
    
    override func loadView() {
        view = questionView
    }
    
    override func configure() {
        selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
        setNavigationItem()
        setCollectionView()
        addTarget()
    }
    
    override func layouts() {
        
    }
    
    func addTarget() {
        questionView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func sortButtonTapped() {
        let vc = CustomSortViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                return UIScreen.main.bounds.height * 0.3
            })]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        vc.delegate = self
        vc.folderID = self.folderID
        vc.targetModel = .question
        present(vc, animated: true)
    }
}

// MARK: - setNavigationItem
extension QuestionViewController {
    func setNavigationItem() {
    
        navigationItem.title = selectedFolder.first?.folderTitle
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black

        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
        
        let searchBarController = BaseSearchController()
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.barStyle = .default
        searchBarController.searchBar.showsCancelButton = true
        searchBarController.searchBar.setShowsCancelButton(true, animated: true)
        if let cancelButton = searchBarController.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
        }
        
        searchBarController.searchBar.searchTextField.placeholder = " 질문을 검색해 보세요"
        navigationItem.searchController = searchBarController
    }
    
    @objc
    func addButtonTapped() {
        let vc = EditQuestionViewController()
        vc.folderID = folderID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate
extension QuestionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
        questionView.questionCollectionView.reloadData()
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            let result = questions.where {
                $0.questionTitle.contains(searchText)
            }
            print(result.count)
            questions = result
        }
        questionView.questionCollectionView.reloadData()
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
        
        if searchText.isEmpty {
            questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
            questionView.questionCollectionView.reloadData()
        }
         else {
            let result = questions.where {
                $0.questionTitle.contains(searchText)
            }
            questions = result
            questionView.questionCollectionView.reloadData()
        }
    }
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        questionView.questionCollectionView.delegate = self
        questionView.questionCollectionView.dataSource = self
        questionView.questionCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row

        cell.interviewDateCntButton.isHidden = true
        cell.questionCntLabel.text = "2분 30초"
        cell.editButton.isHidden = true
        cell.cellTitleLabel.text = questions[row].questionTitle
        cell.questionCntLabel.text = questions[row].limitTimeToString
        cell.interviewDateLabel.text = questions[row].creationDate.dateFormatter + " 생성"
        
        let familiarityDegree:Int = questions[row].familiarityDegree
        if let lightImage = returnLightImage(familiarityDegree: familiarityDegree) {
            cell.customLevelStackView.levelStatusImageView.image = lightImage
        }
        
        cell.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
                let row = indexPath.row
                let vc = DetailReplyViewController()
                
                vc.questionID = self.questions[row].questionID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension QuestionViewController: passTextData {
    
    func passData<T>(selectedObjects: T) {
        self.questions = selectedObjects as? Results<QuestionModel>
        self.questionView.questionCollectionView.reloadData()
    }
}
