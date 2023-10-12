//
//  CustomSortViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/02.
//

import UIKit
import SnapKit
import RealmSwift

protocol passTextData {
    func passData<T>(selectedObjects: T)
}

class CustomSortViewController: BaseViewController {
    
    lazy var customSortView = CustomSortView()
    private var tapGesture: UITapGestureRecognizer?
    var delegate: passTextData?
    let repo = CRUDManager.shared
    var folderID = ObjectId()
    
    enum targetModelType {
        case folder
        case question
    }
    
    var targetModel: targetModelType = .folder
    
    override func configure() {
        self.view.backgroundColor = .white
        tapGestureSet()
        addTarget()
    }
    
    private func tapGestureSet() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        
        if let tapGesture = tapGesture{
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }

    override func layouts() {
        
        view.addSubview(customSortView)
        
        customSortView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CustomSortViewController {
    
    func addTarget() {
        customSortView.sortByLevelButton.addTarget(self, action: #selector(sortByLevelButtonTapped), for: .touchUpInside)
        customSortView.sortByNewButton.addTarget(self, action: #selector(sortByNewButtonTapped), for: .touchUpInside)
        customSortView.sortByOldButton.addTarget(self, action: #selector(sortByOldButtonTapped), for: .touchUpInside)
        customSortView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func sortByLevelButtonTapped() {
        if targetModel == .folder {
            let folders = repo.read(object: FolderModel.self)
            delegate?.passData(selectedObjects: folders)
            dismiss(animated: true)
        } else {
            let selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
            let questions = selectedFolder.first?.questions
            let sortedQuestion = questions?.sorted(byKeyPath: "familiarityDegree", ascending: false)
            
            delegate?.passData(selectedObjects: sortedQuestion)
            dismiss(animated: true)
        }
    }
    
    @objc
    func sortByNewButtonTapped() {
        if targetModel == .folder {
            let folders = repo.readSorted(object: FolderModel.self, bykeyPath: "interviewDate", ascending: true)
            delegate?.passData(selectedObjects: folders)
            dismiss(animated: true)
            
        } else {
            let selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
            let questions = selectedFolder.first?.questions
            let sortedQuestion = questions?.sorted(byKeyPath: "creationDate", ascending: true)
            delegate?.passData(selectedObjects: sortedQuestion)
            dismiss(animated: true)
        }
    }
    
    @objc
    func sortByOldButtonTapped() {
        if targetModel == .folder {
            let folders = repo.readSorted(object: FolderModel.self, bykeyPath: "interviewDate", ascending: false)
            delegate?.passData(selectedObjects: folders)
            dismiss(animated: true)
            
        } else {
            let selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
            let questions = selectedFolder.first?.questions
            let sortedQuestion = questions?.sorted(byKeyPath: "creationDate", ascending: false)
            delegate?.passData(selectedObjects: sortedQuestion)
            dismiss(animated: true)
        }
    }
    
    @objc
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
