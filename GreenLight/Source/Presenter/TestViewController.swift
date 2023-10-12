////
////  ViewController.swift
////  GreenLight
////
////  Created by Dongwan Ryoo on 2023/09/21.
////
//
//import UIKit
//import SnapKit
//
//class ViewController: UIViewController {
//
//    let repo = CRUDManager()
//
//    lazy var button = UIButton()
//
//    let object = FolderModel(folderTitle: "1", interviewDate: Date())
//    let object2 = FolderModel(folderTitle: "2", interviewDate: Date())
//    let object3 = FolderModel(folderTitle: "3", interviewDate: Date())
//
//    let question = QuestionModel(questionTitle: "Sample Question", familiarityDegree: "High", creationDate: Date(), limitTime: Date())
//
//    let question2 = QuestionModel(questionTitle: "Sample Question2", familiarityDegree: "High", creationDate: Date(), limitTime: Date())
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let objects = [object, object2, object3]
//        question.forlders.append(objectsIn: objects)
//        question2.forlders.append(objectsIn: objects)
//
//        repo.write(object: question, writetype: .add)
//        repo.write(object: question2, writetype: .add)
//
//
//        repo.realmFileLocation()
//        buttonSet()
//        view.backgroundColor = .white
//
//    }
//
//    func buttonSet() {
//        view.addSubview(button)
//        button.setTitle("클릭", for: .normal)
//        button.backgroundColor = .black
//        button.titleLabel?.textColor = .white
//        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
//        button.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//    }
//
//    @objc
//    func clicked() {
//        repo.delete(object: object)
//    }
//}
