//
//  BaseSearchBar.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

class BaseSearchController: UISearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeholder = " 질문을 검색해 보세요"
        searchBar.placeholder = placeholder
        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = true
        automaticallyShowsCancelButton = false
    }
}


