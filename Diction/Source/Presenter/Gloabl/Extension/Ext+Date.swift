//
//  DayCntHelper.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import Foundation

extension Date {
    var cntDday: String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let dateComponents = calendar.dateComponents([.day], from: currentDate, to: self)
        if let days = dateComponents.day {
            if days == 0 {
                return "D-day!"
            } else if days > 0 {
                return "D-\(days)"
            } else {
                return "D+\(abs(days))"
            }
        } else {
            return "날짜 계산 오류"
        }

    }
    
    var dateFormatter: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM월 dd일 E"
        
        return dateFormatter.string(from: self)
    }
    
    var detailDateFormatter: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM월 dd일 E HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
    
    var weekAgo: Date {
        let calendar = Calendar.current
    
        return calendar.date(byAdding: .day, value: -7, to: Date())!
    }
    
    var convertWeekToString: String {
        let current = Date().dateFormatter
        let weekAgo = self.weekAgo.dateFormatter
        
        return "\(current) ~ \(weekAgo)"
    }
}
