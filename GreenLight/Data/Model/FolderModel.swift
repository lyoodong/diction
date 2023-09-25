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
    
//    var questionArray: [String] {
//        return questions.map{$0}
//    }

    let ofQuestion = LinkingObjects(fromType: QuestionModel.self, property: "folderID")
    
    convenience init(folderID: ObjectId, folderTitle: String, interviewDate: Date) {
        self.init()
        self.folderID = folderID
        self.folderTitle = folderTitle
        self.interviewDate = interviewDate
    }
}
