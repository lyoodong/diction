//
//  MainViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import RealmSwift

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    private let vm = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }
    
    override func configure() {
        setNavigationItem()
        setCollectionView()
        addTarget()
        vm.setRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.setRealm()
        homeView.homeCollectionView.reloadData()
    }
}

// MARK: - setNavigationItem

extension HomeViewController {
    
    private func setNavigationItem() {
        
        let logoImage = UIImage(systemName: "waveform.circle.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        logoBarButton.tintColor = .mainBlue
        addButton.tintColor = .mainBlue
    
        navigationItem.title = "My Feed."
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = logoBarButton
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationController?.navigationBar.prefersLargeTitles = true
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
        return vm.fetchFolderCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setHomeCollectioviewCell(folders: vm.fetchFolders(), indexPath: indexPath)
        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
                let vc = QuestionViewController()
                vc.vm.folderID = self.vm.fetchSelectedFolderID(row: indexPath.row)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc
    func editButtonTapped(sender: UIButton) {
        setEditButtonMenu(sender: sender)
    }
    
    func setEditButtonMenu(sender:UIButton) {
        let favorite = UIAction(title: "수정하기", handler: { _ in print("수정하기") })
        let cancel = UIAction(title: "삭제하기", attributes: .destructive, handler: { _ in print("삭제") })
        
        let menu = UIMenu(title: "폴더를 수정해주세요.", image: nil, identifier: nil, options: .displayInline, children: [favorite, cancel])
        sender.menu = menu
        sender.changesSelectionAsPrimaryAction = false
        sender.showsMenuAsPrimaryAction = true
    }
}

extension HomeViewController: passTextData {
    func passData<T>(selectedObjects: T) {
//        self.folders = selectedObjects as? Results<FolderModel>
    }
}

// MARK: - addTarget
extension HomeViewController {
    
    func addTarget() {
        homeView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
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
        vc.targetModel = .folder
        present(vc, animated: true)
    }
    
    @objc
    func addButtonTapped() {
        let vc = EditFolderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






