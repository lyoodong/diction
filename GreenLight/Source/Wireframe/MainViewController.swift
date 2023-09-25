//
//  MainViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var questionBox: UIView!
    @IBOutlet var questionBox2: UIView!
    @IBOutlet var questionBox3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [questionBox, questionBox2, questionBox3]
        
        views.forEach { view in
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.black.cgColor
            view?.layer.cornerRadius = 10
        }

    }

}
