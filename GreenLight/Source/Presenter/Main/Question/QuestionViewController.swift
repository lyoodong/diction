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
    let vm = QuestionViewModel()
    let sortVm = DependencyContainer.shared.customSortViewModel

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.setRealm()
        vm.checkQuestionIsEmpty()
        questionView.questionCollectionView.reloadData()
    }
    
    override func loadView() {
        view = questionView
    }
    
    override func configure() {
        vm.setRealm()
        setNavigationItem()
        setCollectionView()
        addTarget()
    }
    
    override func bind() {
        
        sortVm.sortByLevel.bind { [weak self] _ in
            self?.vm.fetchQuestionsByLevel()
            self?.questionView.questionCollectionView.reloadData()
        }
        
        sortVm.sortByNew.bind { [weak self] _ in
            self?.vm.fetchQuestionsbyNew()
            self?.questionView.questionCollectionView.reloadData()
        }
        
        sortVm.sortByOld.bind { [weak self] _ in
            self?.vm.fetchQuestionsByOld()
            self?.questionView.questionCollectionView.reloadData()
        }
        
        vm.questionsIsEmpty.bind { [weak self] value in
            self?.questionView.emptyText.isHidden = !value
        }
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
        vc.folderID = vm.folderID
        vc.targetModel = .question
        present(vc, animated: true)
    }
}

// MARK: - setNavigationItem
extension QuestionViewController {
    func setNavigationItem() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        let searchBarController = BaseSearchController()
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.barStyle = .default
        searchBarController.searchBar.showsCancelButton = true
        searchBarController.searchBar.searchTextField.placeholder = " 질문을 검색해 보세요"
        if let cancelButton = searchBarController.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("취소", for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
        }
        navigationItem.title = vm.fetchNavigationTitle()
        navigationItem.rightBarButtonItem = addButton
        navigationItem.searchController = searchBarController
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainBlue
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
    }
    
    @objc
    func addButtonTapped() {
        let vc = EditQuestionViewController()
//        vc.folderID = vm.folderID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate
extension QuestionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vm.setRealm()
        questionView.questionCollectionView.reloadData()
    
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            vm.filteredQuestionsBySearchText(searchText: searchText)
        }
        questionView.questionCollectionView.reloadData()
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.setRealm()
        
        if searchText.isEmpty {
            vm.fetchQuestions()
        } else {
             vm.filteredQuestionsBySearchText(searchText: searchText)
        }
        questionView.questionCollectionView.reloadData()
    }
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        questionView.questionCollectionView.delegate = self
        questionView.questionCollectionView.dataSource = self
        questionView.questionCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.fetchQuestionCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setQuestionCollectionViewCell(questions: vm.questions, indexPath: indexPath)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cellClickAnimation(view: cell) {
                let row = indexPath.row
                let vc = DetailReplyViewController()

                vc.vm.questionID = self.vm.questions[row].questionID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension QuestionViewController: passTextData {
    
    func passData<T>(selectedObjects: T) {
//        self.questions = selectedObjects as? Results<QuestionModel>
//        self.questionView.questionCollectionView.reloadData()
    }
}
