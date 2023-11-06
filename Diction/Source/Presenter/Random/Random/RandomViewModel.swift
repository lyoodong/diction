//
//  RandomViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/13.
//

import Foundation
import RealmSwift

class RandomViewModel {
    
    let repo = CRUDManager.shared
    var folders: Results<FolderModel>!
    var foldersIsEmpty = Observable(false)
    
    init() {
        setRealm()
        checkFolderIsEmpty()
    }
    
    func setRealm() {
        folders = repo.read(object: FolderModel.self).filter("questions.@count > 0")
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
    
    func fetchSelectedFolderID(indexPath: IndexPath) -> ObjectId {
        return folders[indexPath.row].folderID
    }
}
