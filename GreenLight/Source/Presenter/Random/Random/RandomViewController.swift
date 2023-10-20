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
        vm.checkFolderIsEmpty()
        randomView.randomCollectionView.reloadData()
    }

    override func configure() {
        setNavigationItem()
        setRandomCollectionView()
    }
    
    override func bind() {
        vm.foldersIsEmpty.bind { [weak self] value in
            self?.randomView.emptyText.isHidden = !value
            self?.randomView.emptyAnimationView.isHidden = !value
            if value {
                self?.randomView.emptyAnimationView.play()
            } else {
                self?.randomView.emptyAnimationView.pause()
            }
        }
    }

}

extension RandomViewController {
    private func setNavigationItem() {
        
        let logoImage = UIImage(systemName: "waveform.circle.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        logoBarButton.tintColor = .mainBlue
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .red
    
        navigationItem.title = "Do It Random Practice"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = logoBarButton

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
    
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
            cellClickAnimation(view: cell) {
                let vc = CameraViewController(cameraViewModel: CameraViewModel())
                vc.cameraViewModel.objectID.value = self.vm.fetchSelectedFolderID(indexPath: indexPath)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
