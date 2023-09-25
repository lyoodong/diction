//
//  NewQuestionViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/21.
//

import UIKit

class NewQuestionViewController: UIViewController {
    
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11]
        
        buttons.forEach { UIButton in
            UIButton?.layer.cornerRadius = 10
        }

        
    }

}
