//
//  EditNameViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import Foundation

enum nickNameError: Error {
    case emptyText
    case exceededText
    case numberText
    case spaceInText
}

class EditNameViewModel {
    var nickNameText = Observable("")
    
    func checkValidation() throws {
        
        if nickNameText.value.isEmpty {
            throw nickNameError.emptyText
        } else if nickNameText.value.count > 9 {
            throw nickNameError.exceededText
        } else if let _ = Int(nickNameText.value) {
            throw nickNameError.numberText
        } else if nickNameText.value.contains(" ") {
            throw nickNameError.spaceInText
        }
    }
    
    func checkButtonStatus() -> Bool {
        if !nickNameText.value.isEmpty {
            return true
        }
        return false
    }
}
