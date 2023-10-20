//
//  Privacy PolicyController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import Foundation

class PolicyViewController: BaseViewController {
    
    let policyView = PolicyView()
    
    override func loadView() {
        view = policyView
    }
    
}
