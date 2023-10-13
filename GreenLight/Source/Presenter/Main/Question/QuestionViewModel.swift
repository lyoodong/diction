//
//  QuestionViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/12.
//

import Foundation
import RealmSwift

class QuestionViewModel {
    
    let repo = CRUDManager.shared
    var folderID: ObjectId = ObjectId()
    var selectedFolder: Results<FolderModel>!
    var questions: Results<QuestionModel>!
    
    func setRealm() {
        selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
    }
    
    func fetchQuestionCnt() -> Int {
        return questions.count
    }
    
    func fetchQuestions() {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "creationDate", ascending: true)
    }
    
    func fetchNavigationTitle() -> String {
        return selectedFolder.first?.folderTitle ?? "응답"
    }
    
    func filteredQuestionsBySearchText(searchText: String)  {
        if searchText.isEmpty {
            setRealm()
        } else {
            questions = questions.where { $0.questionTitle.contains(searchText) }
        }
    }
    
}
