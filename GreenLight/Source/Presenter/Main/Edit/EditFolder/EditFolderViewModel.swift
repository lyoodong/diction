//
//  EditFolderViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/14.
//

import Foundation
import RealmSwift

class EditFolderViewModel{
    
    var interviewDate = Observable(Date())
    var folderTitle = Observable("")
    var isButtonEnabled = Observable(false)
    var folder = Observable(FolderModel())
    
    let repo = CRUDManager.shared
    
    init() {

    }
        
    func checkButtonState() {
        isButtonEnabled.value = !folderTitle.value.isEmpty && interviewDate.value.dateFormatter != Date().dateFormatter
    }

    func createFolder() {
        let objc = FolderModel(folderTitle: folderTitle.value, interviewDate: interviewDate.value)
        repo.write(object: objc)
    }
    
    func updateFolderData() {
        folderTitle.value = folder.value.folderTitle
        interviewDate.value = folder.value.interviewDate
    }

    func updateFolder() {
        let realm = try! Realm()
        
        try! realm.write {
            folder.value.folderTitle = folderTitle.value
            folder.value.interviewDate = interviewDate.value
        }
        
    }
}
