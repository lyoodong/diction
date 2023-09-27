//
//  AnswerModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class AnswerModel: Object {
    @Persisted(primaryKey: true) var answerID: ObjectId
    @Persisted var answerRecord: String
    @Persisted var creationDate: Date
    @Persisted var answeringTime: Date
    
    convenience init( answerRecord: String, creationDate: Date, answeringTime: Date) {
        self.init()
        self.answerRecord = answerRecord
        self.creationDate = creationDate
        self.answeringTime = answeringTime
    }
}
