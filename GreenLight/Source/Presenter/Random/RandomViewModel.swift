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
    
    func setRealm() {
        folders = repo.read(object: FolderModel.self)
    }
    
    func fetchFolderCnt() -> Int {
        return folders.count
    }
    
    func fetchSelectedFolderID(indexPath: IndexPath) -> ObjectId {
        return folders[indexPath.row].folderID
    }
    
}
