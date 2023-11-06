//
//  StatisticsViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/17.
//

import Foundation
import RealmSwift
import Realm

class StatisticsViewModel {
    
    let repo = CRUDManager.shared

    func fetchWeeklyModel<T:Object>(with model: T.Type) -> Results<T> {
        let weeklyModel = repo.read(object: model)
            .filter("createdDate >= %@", Date().weekAgo)
        
        return weeklyModel
    }
    
    func fetchWeeklyAnsweringTime() -> TimeInterval {
        let weeklyAnswerModels = fetchWeeklyModel(with: AnswerModel.self)
        
        let totalTime = weeklyAnswerModels.reduce(0) { time, component in
            return time + component.answeringTime
        }
        
        return totalTime
    }
    
    func fetchWeeklyModelCount<T:Object> (with model: T.Type) -> Int{
        return fetchWeeklyModel(with: model).count
    }
    
    
}
