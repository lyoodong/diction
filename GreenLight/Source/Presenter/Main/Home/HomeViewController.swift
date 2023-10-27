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
    private let sortVm = DependencyContainer.shared.customSortViewModel
    
    override func loadView() {
        view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.setRealm()
        vm.checkFolderIsEmpty()
        homeView.homeCollectionView.reloadData()
    }

    override func configure() {
        vm.setRealm()
        homeView.homeCollectionView.reloadData()
        setNavigationItem()
        setCollectionView()
        addTarget()
        
    }

    override func bind() {
    
        sortVm.sortByLevel.bind { [weak self] _ in
            self?.vm.fetchFoldersByLevel()
            self?.homeView.homeCollectionView.reloadData()
        }
        
        sortVm.sortByNew.bind { [weak self] _ in
            self?.vm.fetchFoldersbyNew()
            self?.homeView.homeCollectionView.reloadData()
        }
        
        sortVm.sortByOld.bind { [weak self] _ in
            self?.vm.fetchFoldersByOld()
            self?.homeView.homeCollectionView.reloadData()
        }
        
        vm.foldersIsEmpty.bind { [weak self] value in
            self?.homeView.emptyText.isHidden = !value
            self?.homeView.emptyAnimationView.isHidden = !value
            if value {
                self?.homeView.emptyAnimationView.play()
            } else {
                self?.homeView.emptyAnimationView.pause()
            }
        }
    }
}

// MARK: - setNavigationItem

extension HomeViewController {
    
    private func setNavigationItem() {
        
        let logoImage = UIImage(named: "Logo")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.title = "전체 보드"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = logoBarButton
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = .mainBlue
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
        
//        if indexPath.row == 0 {
//            cell.backgroundColor = .blue
//        } else {
            cell.setHomeCollectioviewCell(folders: vm.fetchFolders(), indexPath: indexPath)
            cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cellClickAnimation(view: cell) {
                let vc = QuestionViewController()
                vc.vm.folderID = self.vm.fetchSelectedFolderID(row: indexPath.row)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc
    func editButtonTapped(sender: UIButton) {
        
        if let indexPath = homeView.homeCollectionView.indexPath(for: sender.superview as! UICollectionViewCell) {
            setEditButtonMenu(sender: sender, indexPath: indexPath)
        }
    }
    
    func setEditButtonMenu(sender:UIButton, indexPath: IndexPath) {
        let favorite = UIAction(title: "수정하기", handler: { _ in
            self.editSelectedFolder(indexPath: indexPath)
            
        })
                                
        let cancel = UIAction(title: "삭제하기", attributes: .destructive, handler: { _ in
            self.vm.deleteSelectedFolder(indexPath: indexPath)
            self.showOneWayAlert(title: "삭제되었습니다.")
            self.homeView.homeCollectionView.reloadData()
        })
        
        let menu = UIMenu(title: "폴더를 수정해주세요.", image: nil, identifier: nil, options: .displayInline, children: [favorite, cancel])
        sender.menu = menu
        sender.changesSelectionAsPrimaryAction = false
        sender.showsMenuAsPrimaryAction = true
    }
                                
    func editSelectedFolder(indexPath: IndexPath) {
        let vc = EditFolderViewController()
        let folder = vm.folders[indexPath.row]
        vc.vm.folder.value = folder
        vc.isEdited = true
        vc.vm.updateFolderData()
        self.navigationController?.pushViewController(vc, animated: true)
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






