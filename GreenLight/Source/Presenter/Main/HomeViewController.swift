//
//  MainViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewSet() {
        setNavigationItem()
        setCollectionView()
    }
    
    override func constraints() {
        
    }
    
}

// MARK: - setNavigationItem
extension HomeViewController {
    
    func setNavigationItem() {
        navigationItem.title = "나의 질문"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .default
        
        
        let logoImage = UIImage(systemName: "star.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = logoBarButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addButton
        
        let searchBarController = BaseSearchController()
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.searchTextField.backgroundColor = .white
        searchBarController.searchBar.searchTextField.placeholder = " 질문을 검색해 보세요"
        navigationItem.searchController = searchBarController
    }
    
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        homeView.mainCollectionView.delegate = self
        homeView.mainCollectionView.dataSource = self
        homeView.mainCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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



