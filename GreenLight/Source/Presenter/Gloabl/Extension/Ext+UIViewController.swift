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
    
    func cellClickAnimation(view: UIView, completion: @escaping () -> Void) {
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
    
    func buttonClickAnimation(view: UIView,ogBackgourdColor: UIColor , completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            view.backgroundColor = .systemGray6
        },
        completion: { _ in
            UIView.animate(withDuration: 0.05) {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                view.backgroundColor = ogBackgourdColor
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
    
    func showOneWayAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showTwoWayAlert(title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
