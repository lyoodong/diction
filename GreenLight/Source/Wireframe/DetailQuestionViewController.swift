//
//  DetailQuestionViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/21.
//

import UIKit
import SnapKit

class DetailQuestionViewController: UIViewController {

    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [view1, view2]

        views.forEach { view in
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.black.cgColor
            view?.layer.cornerRadius = 10
        }
        
    }

}
