//
//  MyViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/21.
//

import UIKit

class MyViewController: UIViewController {
    
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [view1, view2, view3]
        let buttons = [button1, button2, button3]
        
        views.forEach { view in
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.black.cgColor
            view?.layer.cornerRadius = 10
        }
        
        buttons.forEach { view in
            view?.layer.cornerRadius = 10
        }
        
    }
}
