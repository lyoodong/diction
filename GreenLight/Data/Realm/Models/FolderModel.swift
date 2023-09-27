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
    @Persisted var questions = List<QuestionModel>()
    
//    var questionArray: [String] {
//        return questions.map{$0}
//    }

//    let ofQuestion = LinkingObjects(fromType: QuestionModel.self, property: "folderID")
    
    convenience init(folderTitle: String, interviewDate: Date) {
        self.init()
        self.folderTitle = folderTitle
        self.interviewDate = interviewDate
    }
}
