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
    var questionsIsEmpty = Observable(false)
    
    
    func setRealm() {
        selectedFolder = repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: folderID)
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "createdDate", ascending: true)
    }
    
    func checkQuestionIsEmpty() {
        if questions.isEmpty {
            questionsIsEmpty.value = true
        } else {
            questionsIsEmpty.value = false
        }
    }
    
    func fetchQuestionCnt() -> Int {
        return questions.count
    }
    
    func fetchQuestions() {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "createdDate", ascending: true)
    }
    
    func fetchQuestionsByLevel() {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "familiarityDegree", ascending: false)
    }
    
    func fetchQuestionsbyNew() {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "createdDate", ascending: true)
    }
    
    func fetchQuestionsByOld() {
        questions = selectedFolder.first?.questions.sorted(byKeyPath: "createdDate", ascending: false)
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
