//
//  questionModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class QuestionModel: Object {
    @Persisted(primaryKey: true) var questionID: ObjectId
    @Persisted var questionTitle: String
    @Persisted var familiarityDegree: String
    @Persisted var creationDate: Date
    @Persisted var limitTime: Date
        
    let forlders = List<ObjectId>()
    
    convenience init(questionID: ObjectId, questionTitle: String, familiarityDegree: String, creationDate: Date, limitTime: Date) {
        self.init()
        self.questionID = questionID
        self.questionTitle = questionTitle
        self.familiarityDegree = familiarityDegree
        self.creationDate = creationDate
        self.limitTime = limitTime
    }
}
