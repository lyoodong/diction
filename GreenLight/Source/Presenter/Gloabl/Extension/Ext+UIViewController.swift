//
//  Ext+UIViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import UIKit

extension UIViewController: ReturnIDF {
    static var IDF: String {
        return String(describing: self)
    }
    
    func clickAnimation(view: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            view.backgroundColor = .systemGray6
        },
        completion: { _ in
            UIView.animate(withDuration: 0.05) {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                view.backgroundColor = .white
          }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            completion()
        }
    }
    
    func returnLightImage(familiarityDegree:Int) -> UIImage? {
        switch familiarityDegree {
        case 0..<5:
            return UIImage(named: "RedLight")
        case 5..<7:
            return UIImage(named: "YellowLight")
        case 7...9 :
            return UIImage(named: "GreenLight")
        default:
            return UIImage(named: "RedLight")
        }
    }
   
}
