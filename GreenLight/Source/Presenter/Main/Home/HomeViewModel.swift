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
    private var folders: Results<FolderModel>!

    
    func setRealm() {
        folders = repo.read(object: FolderModel.self)
    }
    
    func fetchFolderCnt() -> Int {
        return folders.count
    }
    
    func fetchFolders() -> Results<FolderModel> {
        
        folders = repo.read(object: FolderModel.self)
        return folders
        
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
    }
    
    func fetchSelectedFolderID(row: Int) -> ObjectId {
        return folders[row].folderID
    }
    
}
