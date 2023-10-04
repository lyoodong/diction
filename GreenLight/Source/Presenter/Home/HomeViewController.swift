//
//  MainViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewSet() {
        setNavigationItem()
        setCollectionView()
        addTarget()
    }
    
    func addTarget() {
        homeView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func sortButtonTapped() {
        let vc = CustomSortViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
    }
}

// MARK: - setNavigationItem

extension HomeViewController {
    
    private func setNavigationItem() {
    
        self.navigationItem.title = "나의 질문"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 26)]
        
        let logoImage = UIImage(systemName: "star.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        logoBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = logoBarButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
        self.navigationItem.title = "나의 질문"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
        homeView.homeCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = QuestionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



