//
//  MainViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import RealmSwift
import SkeletonView

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    
    let repo = CRUDManager.shared
    
    var folders: Results<FolderModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folders = repo.read(object: FolderModel.self)
        homeView.homeCollectionView.reloadData()
    }

    override func loadView() {
        view = homeView
    }
    
    override func configure() {
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
}

// MARK: - setNavigationItem

extension HomeViewController {
    
    private func setNavigationItem() {
    
        self.navigationItem.title = "My Feed."
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 26)]
        
        let logoImage = UIImage(systemName: "waveform.circle.fill")
        let logoBarButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        logoBarButton.tintColor = .mainBlue
        navigationItem.leftBarButtonItem = logoBarButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .mainBlue
        navigationItem.rightBarButtonItem = addButton
    
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
        let count = folders.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        cell.cellTitleLabel.text = folders[row].folderTitle
        cell.interviewDateLabel.text = folders[row].interviewDate.dateFormatter + "  | "
        cell.interviewDateCntButton.setTitle("  " + folders[row].interviewDate.cntDday + "  ", for: .normal)
        cell.questionCntLabel.text = "\(folders[row].questions.count)개의 질문"
        cell.addShadow()
        
        if let firstFolder = folders.first {
            let questionsList = firstFolder.questions
            let familiarityDegrees = questionsList.map { $0.familiarityDegree }
            
            if !familiarityDegrees.isEmpty {
                let averageFamiliarity = familiarityDegrees.reduce(0, +) / familiarityDegrees.count
                cell.customLevelStackView.levelStatusImageView.image = returnLightImage(familiarityDegree: averageFamiliarity)
            } else {
                print("폴더에 질문이 없습니다.")
            }
        } else {
            print("폴더가 없습니다.")
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            clickAnimation(view: cell) {
                let vc = QuestionViewController()
                vc.folderID = self.folders[indexPath.row].folderID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc
    func editButtonTapped(sender: UIButton) {
        let favorite = UIAction(title: "수정하기", handler: { _ in print("수정하기") })
        let cancel = UIAction(title: "삭제하기", attributes: .destructive, handler: { _ in print("삭제") })
        
        let menu = UIMenu(title: "폴더를 수정해주세요.", image: nil, identifier: nil, options: .displayInline, children: [favorite, cancel])
        sender.menu = menu
        sender.changesSelectionAsPrimaryAction = false
        sender.showsMenuAsPrimaryAction = true
    }
    
    @objc
    func addButtonTapped() {
        let vc = EditFolderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: passTextData {
    func passData<T>(selectedObjects: T) {
        self.folders = selectedObjects as? Results<FolderModel>
        homeView.homeCollectionView.reloadData()
    }
}






