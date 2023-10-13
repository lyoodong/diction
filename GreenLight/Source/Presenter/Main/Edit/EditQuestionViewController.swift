//
//  EditQuestionViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit
import RealmSwift

class EditQuestionViewController: BaseViewController {
    
    let editQuestionView = EditQuestionView()
    let repo = CRUDManager.shared
    var folders: Results<FolderModel>!
    var selectedFoldersList = List<FolderModel>()
    var selectedMinutes: Int = 0
    var selectedSeconds: Int = 0
    var selectedIndex: [Int] = []
    var folderID = ObjectId()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folders = repo.read(object: FolderModel.self)
        editQuestionView.folderSelectCollectionView.reloadData()
    }
    
    override func loadView() {
        view = editQuestionView
    }
    
    override func configure() {
        super.configure()
        setlimitTimePickerView()
        setCollectionView()
        addTarget()
    }
}

//MARK: - addtarget
extension EditQuestionViewController {
    
    func addTarget() {
        editQuestionView.questionLevelEditButton.addTarget(self, action: #selector(questionLevelEditButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func questionLevelEditButtonTapped() {
        
        guard let title = editQuestionView.questionTitleTextFields.textFields.text else {
             return
        }
        
        guard let familiarityDegree = editQuestionView.familiarDegreeTextFields.textFields.text else {
             return
        }
        
        //필터해서 기존의 folderId가 존재하면 중복방지하는 로직 추가
        let objc = QuestionModel(questionTitle: title, familiarityDegree: familiarityDegree.toInt, creationDate: Date(), limitTimeMinutes: selectedMinutes, limitTimeSeconds: selectedSeconds, folders: selectedFoldersList)

        //realm에서 트랜잭션의 정확한 개념
        //write의 용례 이해하기
        repo.write(object: objc)
        
        let realm = try! Realm()
        
        try! realm.write {
            for item in selectedFoldersList {
                item.questions.append(objc)
            }
        }
    }
}

extension EditQuestionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setlimitTimePickerView() {
        editQuestionView.limitTimePickerView.delegate = self
        editQuestionView.limitTimePickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectedMinutes = row
        } else if component == 1 {
            selectedSeconds = row
        }
        
        editQuestionView.limitTimeTextFields.text = String(format: "%02d분%02d초", selectedMinutes, selectedSeconds)
    }
    
}

extension EditQuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        editQuestionView.folderSelectCollectionView.delegate = self
        editQuestionView.folderSelectCollectionView.dataSource = self
        editQuestionView.folderSelectCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = folders.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.editButton.isHidden = true
        
        let row = indexPath.row
        
        cell.cellTitleLabel.text = folders[row].folderTitle
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd.E"
        let formattedDate = dateFormatter.string(from: folders[row].interviewDate)
        
        cell.interviewDateLabel.text = formattedDate + " | "
        cell.interviewDateCntButton.setTitle(folders[row].interviewDate.cntDday, for: .normal)
                
        cell.questionCntLabel.text = "\(folders[row].questions.count)개"
        
        if selectedIndex.contains(indexPath.row) {
            cell.backgroundColor = .mainBlue
        } else {
            cell.backgroundColor = .white
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        if selectedIndex.contains(row) {
            if let index = selectedIndex.firstIndex(of: row) {
                selectedIndex.remove(at: index)
                selectedIndex.sort { $1 > $0 }
                print(selectedIndex)
            }
        } else {
            selectedIndex.append(row)
            selectedIndex.sort { $1 > $0 }
            print(selectedIndex)
        }
        selectedFoldersList.removeAll()
        for index in selectedIndex {
            if index < folders.count {
                let folder = folders[index]
                selectedFoldersList.append(folder)
                print(selectedFoldersList)
            } else {
                print("index 초과 에러")
            }
        }
        collectionView.reloadItems(at: [indexPath])
    }
}
