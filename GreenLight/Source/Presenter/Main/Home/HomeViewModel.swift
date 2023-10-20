//
//  HomeViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/12.
//

import Foundation
import RealmSwift

class HomeViewModel {
    
    private let repo = CRUDManager.shared
    var folders: Results<FolderModel>!
    var foldersIsEmpty = Observable(false)
    
    init() {
        setRealm()
        checkFolderIsEmpty()
    }

    
    func setRealm() {
        folders = repo.read(object: FolderModel.self).sorted(byKeyPath: "interviewDate", ascending: true)
    }
    
    func checkFolderIsEmpty() {
        if folders.isEmpty {
            foldersIsEmpty.value = true
        } else {
            foldersIsEmpty.value = false
        }
    }
    
    func fetchFolderCnt() -> Int {
        return folders.count
    }
    
    func fetchFolders() -> Results<FolderModel> {
        return folders
    }
    
    func fetchFoldersByLevel() {
        folders = repo.read(object: FolderModel.self).sorted(byKeyPath: "averageLevel", ascending: false)
    }
    
    func fetchFoldersbyNew()  {
        folders = repo.read(object: FolderModel.self).sorted(byKeyPath: "interviewDate", ascending: true)
    }
    
    func fetchFoldersByOld()  {
        folders = repo.read(object: FolderModel.self).sorted(byKeyPath: "interviewDate", ascending: false)
    }
    
    func fetchSelectedFolderID(row: Int) -> ObjectId {
        return folders[row].folderID
    }
    
    func deleteSelectedFolder(indexPath: IndexPath) {
        let realm = try! Realm()
    
        try! realm.write {
            let deleteFolder = realm.objects(FolderModel.self).where {
                $0.folderID == fetchSelectedFolderID(row: indexPath.row)
            }
            
            realm.delete(deleteFolder)
        }
        
        try! realm.write {
            let result = realm.objects(QuestionModel.self).where {
                $0.folders.count == 0
            }
            
            for item in result {
                realm.delete(item)
            }
        }
    }
    
}




//    var sortState = Observable<SortState?>(nil)
//
//    enum SortState {
//        case defaultSet
//        case newSet
//        case oldSet
//        case familiarSet
//    }

//        switch type {
//        case .defaultSet:
//            folders = repo.read(object: FolderModel.self)
//            return folders
//        case .familiarSet:
//            folders = repo.read(object: FolderModel.self)
//            return folders
//        case .oldSet:
//            folders = repo.readSorted(object: FolderModel.self, bykeyPath: "interviewDate", ascending: true)
//            return folders
//        case .newSet:
//            folders = repo.readSorted(object: FolderModel.self, bykeyPath: "interviewDate", ascending: false)
//            return folders
//        }
