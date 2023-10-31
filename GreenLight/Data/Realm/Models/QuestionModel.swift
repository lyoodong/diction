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
    @Persisted var familiarityDegree: Int
    @Persisted var createdDate: Date
    @Persisted var limitTimeMinutes: Int
    @Persisted var limitTimeSeconds: Int
    @Persisted var questionMemoText: String
    @Persisted var folders: List<FolderModel>
    @Persisted var answers = List<AnswerModel>()

    
    var limitTimeToString: String {
        return "\(limitTimeMinutes)분 \(limitTimeSeconds)초"
    }
    
    convenience init(questionTitle: String, familiarityDegree: Int, createdDate: Date, limitTimeMinutes: Int, limitTimeSeconds: Int, folders: List<FolderModel>) {
        self.init()
        self.questionTitle = questionTitle
        self.familiarityDegree = familiarityDegree
        self.createdDate = createdDate
        self.limitTimeMinutes = limitTimeMinutes
        self.limitTimeSeconds = limitTimeSeconds
        self.folders = folders
    }
}
