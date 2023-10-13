//
//  RandomViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

class RandomViewController: BaseViewController {
    
    let randomView = RandomView()
    let vm = RandomViewModel()
    
    override func loadView() {
        view = randomView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.setRealm()
        randomView.randomCollectionView.reloadData()
    }

    override func configure() {
        setNavigationItem()
        setRandomCollectionView()
    }

}

extension RandomViewController {
    private func setNavigationItem() {
        
        let logoImage = UIImage(systemName: "waveform.circle.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        logoBarButton.tintColor = .mainBlue
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .bgGrey
    
    
        navigationItem.title = "Do It Random Practice"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = logoBarButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
//        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
//
    
    }
}

extension RandomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setRandomCollectionView() {
        randomView.randomCollectionView.delegate = self
        randomView.randomCollectionView.dataSource = self
        randomView.randomCollectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.fetchFolderCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RandomCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setRandomCollectioviewCell(folders: vm.folders, indexPath: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
            
            }
        }
   
    }
}
