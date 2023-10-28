//
//  AnswerModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class AnswerModel: Object {
    @Persisted(primaryKey: true) var answerID: String
    @Persisted var createdDate: Date
    @Persisted var answeringTime: TimeInterval
    @Persisted var recordText: String
    @Persisted var recordUrl: String
    @Persisted var questionID: ObjectId
    var answeringTimeToString: String {
        let answeringTime = Int(self.answeringTime)
        let minutes = answeringTime / 60
        let second = answeringTime % 60
        return "\(minutes)분 \(second)초"
    }
    
    
    convenience init(answerID:String, recordText: String, createdDate: Date, answeringTime: TimeInterval, recordUrl: String, questionID: ObjectId) {
        self.init()
        self.answerID = answerID
        self.recordText = recordText
        self.createdDate = createdDate
        self.answeringTime = answeringTime
        self.recordUrl = recordUrl
        self.questionID = questionID
    }
}

