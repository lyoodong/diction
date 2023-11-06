//
//  DependencyContainer.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/18.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    let customSortViewModel = CustomSortViewModel()

}

protocol CustomSortViewModelProtocol: AnyObject {
    var customSortViewModel: CustomSortViewModel { get }
}

protocol EditNameViewModelProtocol: AnyObject {
    var editNameViewModel: EditNameViewModel { get }
}


