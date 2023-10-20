//
//  PracticeViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/15.
//

import Foundation
import RealmSwift

class PracticeViewModel {
    
    var currnetQuestionIndex = Observable(0)
    let repo = CRUDManager.shared
    var questions: List<QuestionModel>!
    var objectID = Observable(ObjectId())
    var limitMinutes = Observable(0)
    var limitSeconds = Observable(0)
    var limitTime = Observable(TimeInterval())
    var limitTimeTxt = Observable("")
    var timer: Timer?
    var familarDegree = Observable(0)
    
    init() {
        fetchLimitTimeTxt()
    }
    
    func fetchProgress() -> Float {
        let index = currnetQuestionIndex.value + 1
        let result = Float(index) / Float(questions.count)
        
        return result
    }
    
    func fetchCurrentIndexTxt() -> String {
        return "\(currnetQuestionIndex.value + 1)번 / \(questions.count)"
    }
    
    func setRealm() {
        objectID.bind { ObjectId in
            let folder = self.repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: ObjectId)
            self.questions = folder.first?.questions
        }
    }
    
    func fetchQuestionCnt() -> Int {
        return questions.count
    }
    
    func fetchQuestionTitle(indexPath: IndexPath) -> String {
        return questions[indexPath.row].questionTitle
    }

    func fetchLimitTime(index: Int){
        limitMinutes.value = questions[index].limitTimeMinutes
        limitSeconds.value = questions[index].limitTimeSeconds
        limitTime.value = TimeInterval(limitMinutes.value * 60 + limitSeconds.value)
    }
    
    func fetchCurrentLimitTime() {
        
        if limitTime.value == 0 {
            return
        }
        
        limitTime.value -= 1
        fetchCurrentLimitTime()
    }
    
    func fetchLimitTimeTxt() {
        limitTime.bind { TimeInterval in
            self.limitTimeTxt.value = self.timeIntervalToString(timeInterval: TimeInterval)
        }
    }
    
    func timeIntervalToString(timeInterval: TimeInterval ) -> String {
        
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func fetchCurrentFamilarDegree() {
        familarDegree.value = questions[currnetQuestionIndex.value].familiarityDegree
    }
    
    func uploadSelectedFamiliarityDegree(value: Int) {
        
        let realm = try! Realm()
        
        try! realm.write {
            questions[currnetQuestionIndex.value].familiarityDegree = value
        }
        
    }
}
