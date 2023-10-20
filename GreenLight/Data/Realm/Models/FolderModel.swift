//
//  FolderModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class FolderModel: Object {
    @Persisted(primaryKey: true) var folderID: ObjectId
    @Persisted var folderTitle: String
    @Persisted var interviewDate: Date
    @Persisted var createdDate = Date()
    @Persisted var questions = List<QuestionModel>()
    @Persisted var averageLevel: Int

    var calculateAverageLevel: Int {
        var sum = 0
        for item in questions {
            sum += item.familiarityDegree
        }
        
        var result = 3
        if questions.count == 0 {

        } else {
            result = sum / questions.count
        }
        
        return result
    }
    
    
    convenience init(folderTitle: String, interviewDate: Date) {
        self.init()
        self.folderTitle = folderTitle
        self.interviewDate = interviewDate
        self.averageLevel = self.calculateAverageLevel
    }
}
