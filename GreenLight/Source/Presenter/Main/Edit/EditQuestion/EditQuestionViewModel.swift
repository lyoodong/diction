//
//  EditQuestionViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/14.
//

import Foundation
import RealmSwift

class EditQuestionViewModel {
    
    var folders: Results<FolderModel>!
    let repo = CRUDManager.shared
    
    var questionTitle = Observable("")
    var questionID = Observable(ObjectId())
    var limitTime = Observable("")
    var limitTimeMinutes = Observable(0)
    var limitTimeSeconds = Observable(0)
    var isCellSelected = Observable(false)
    var familarDegree = Observable(0)
    var selectedMinutes = Observable(0)
    var selectedSeconds = Observable(0)
    var isButtonEnabled = Observable(false)
    var selectedFoldersList = List<FolderModel>()
    var question: Results<QuestionModel>!
    
    init() {
        setRealm()
        checkQuestionTitle()
        checkLimitTime()
        checkisCellSelected()
        checkSelectedMinutes()
        checkSelectedSeconds()
        fetchLimitTime()
    }
    
    func setRealm() {
        folders = repo.read(object: FolderModel.self)
    }
    
    func fetchFolderCnt() -> Int {
        return folders.count
    }
    
    func updateFolderData() {
        question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID.value)
        
        questionTitle.value = question.first!.questionTitle
        selectedMinutes.value = question.first!.limitTimeMinutes
        selectedSeconds.value = question.first!.limitTimeSeconds
        familarDegree.value = question.first!.familiarityDegree
        
        let realm = try! Realm()
        
        try! realm.write {
            selectedFoldersList = question.first!.folders
        }
    }
    
    func checkSelectedMinutes() {
        selectedMinutes.bind { [weak self] _ in
            self?.fetchLimitTime()
        }
    }
    
    func checkSelectedSeconds() {
        selectedSeconds.bind { [weak self] _ in
            self?.fetchLimitTime()
        }
    }
    
    
    func fetchLimitTime() {
        limitTime.value = String(format: "%02d분%02d초", selectedMinutes.value, selectedSeconds.value)
    }

    func checkQuestionTitle() {
        questionTitle.bind { [weak self]_ in
            self?.checkButtonState()
        }
    }
    
    func checkLimitTime() {
        limitTime.bind { [weak self] _ in
            self?.checkButtonState()
        }
    }
    
    func checkisCellSelected() {
        isCellSelected.bind { [weak self]_ in
            self?.checkButtonState()
        }
    }
    
    func checkFamilarDegree() {
        familarDegree.bind { [weak self] _ in
            self?.checkButtonState()
        }
    }
    
    func checkButtonState() {
        let state = !questionTitle.value.isEmpty && familarDegree.value != 0 && !limitTime.value.isEmpty && isCellSelected.value != false
        
        isButtonEnabled.value = state
    }
    
    func creatQuestion() {
        let objc = QuestionModel(questionTitle: questionTitle.value, familiarityDegree: familarDegree.value, createdDate: Date(), limitTimeMinutes: selectedMinutes.value, limitTimeSeconds: selectedSeconds.value, folders: selectedFoldersList)
        
        repo.write(object: objc)
        
        let realm = try! Realm()
        
        try! realm.write {
            for item in selectedFoldersList {
                item.questions.append(objc)
            }
        }
    }
    
    func updateQuestion() {
        let realm = try! Realm()
        
        try! realm.write {
            question.first?.questionTitle = questionTitle.value
            question.first?.familiarityDegree = familarDegree.value
            question.first?.limitTimeMinutes = limitTimeMinutes.value
            question.first?.limitTimeSeconds = limitTimeSeconds.value
            question.first?.folders = selectedFoldersList
        }
    }
}


