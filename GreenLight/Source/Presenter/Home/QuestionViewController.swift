//
//  QuestionViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit

final class QuestionViewController: BaseViewController {
    
    let questionView = QuestionView()
    
    override func loadView() {
        view = questionView
    }
    
    override func viewSet() {
        setNavigationItem()
        setCollectionView()
        addTarget()
    }
    
    override func constraints() {
        
    }
    
    func addTarget() {
        questionView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func sortButtonTapped() {
        let vc = CustomSortViewController()
        vc.modalPresentationStyle = .pageSheet
        
        present(vc, animated: true)
    }
    
}

// MARK: - setNavigationItem
extension QuestionViewController {
    
    func setNavigationItem() {
    
        navigationItem.title = "새싹 5기 면접질문"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
        let searchBarController = BaseSearchController()
        
//        let textFieldInsideSearchBar = searchBarController.searchBar.value(forKey: "searchField") as? UITextField
//        textFieldInsideSearchBar?.borderStyle = .bezel
//        textFieldInsideSearchBar?.backgroundColor = .white
        
        searchBarController.searchBar.searchTextField.borderStyle = .none
        searchBarController.searchBar.searchTextField.backgroundColor = .white
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.barStyle = .black
        searchBarController.searchBar.searchTextField.placeholder = " 질문을 검색해 보세요"
        navigationItem.searchController = searchBarController
    }
    
}

// MARK: - UISearchBarDelegate
extension QuestionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        questionView.questionCollectionView.delegate = self
        questionView.questionCollectionView.dataSource = self
        questionView.questionCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }

}
