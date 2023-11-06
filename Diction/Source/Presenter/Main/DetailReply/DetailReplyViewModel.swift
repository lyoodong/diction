//
//  DetailReplyViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/12.
//

import Foundation
import RealmSwift

class DetailReplyViewModel {
    
    let repo = CRUDManager.shared
    var question: Results<QuestionModel>!
    var questionID = ObjectId()
    var answers: Results<AnswerModel>!
    var memoText: String = ""
    
    func setRealm() {
        question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
        answers = repo.filterByObjcID(object: AnswerModel.self, key: "questionID", objectID: questionID).sorted(byKeyPath: "createdDate", ascending: false)
    }
    
    
    func fetchMemoText() -> String {
        guard let savedMemoText = question.first?.questionMemoText else {
            return "메모를 입력해주세요."
        }
        
        return savedMemoText
    }
    
    func fetchLimitTime() -> String {
        guard let limitTime = question.first?.limitTimeToString else {
            return ""
        }
        
        return limitTime
    }
    
    func fetchAnswersCnt() -> Int {
        return answers.count
    }
    
    func fetchCreatedDate() -> String{
        
        guard let createdDate = question.first?.createdDate else { return
            ""
        }
        
        return createdDate.dateFormatter
        
    }
    
    func fetchFamiliartyDegree() -> Int {
        guard let familiarityDegree = question.first?.familiarityDegree else {
            return 3
        }
        
        return familiarityDegree
    }
    
    func updateMemoText() {
        let realm = try! Realm()
        try! realm.write {
            question.first?.questionMemoText = memoText
            
        }
    }
}
