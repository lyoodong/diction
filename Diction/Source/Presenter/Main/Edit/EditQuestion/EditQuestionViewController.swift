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
    var selectedFoldersList = List<FolderModel>()
    var selectedIndex: [Int] = []
    var isEdited = false
    
    
    let vm = EditQuestionViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editQuestionView.folderSelectCollectionView.reloadData()
    }
    
    override func loadView() {
        view = editQuestionView
    }
    
    override func configure() {
        super.configure()
        setlimitTimePickerView()
        setCollectionView()
        setNavigationItem()
        addTarget()
        setViewData()
    }
    
    func setViewData() {
        vm.isButtonEnabled.bind { [weak self] isEnabled in
            self?.editQuestionView.addButton.isEnabled = isEnabled
            self?.editQuestionView.addButton.backgroundColor = isEnabled ? .mainBlue : .mainBlue?.withAlphaComponent(0.5)
        }
        
        vm.questionTitle.bind { [weak self] value in
            self?.editQuestionView.questionTitleTextFields.textFields.text = value
        }
        
        vm.familarDegree.bind { [weak self] value in
            
            if self?.isEdited == true {
                if value == 3 {
                    self?.editQuestionView.redLevelButton.isSelected = true
                } else if value == 6 {
                    self?.editQuestionView.ornageLevelButton.isSelected = true
                } else {
                    self?.editQuestionView.blueLevelButton.isSelected = true
                }
            }
        }
        
        vm.limitTime.bind { [weak self] value in
            if value != "00분00초" {
                self?.editQuestionView.limitTimeTextFields.textFields.text = value
            }
        }
        selectedFoldersList = vm.selectedFoldersList
        editQuestionView.folderSelectCollectionView.reloadData()
        
        for (index, item) in vm.folders.enumerated() {
            if selectedFoldersList.contains(item) {
                selectedIndex.append(index)
            }
        }
    }
}

//MARK: - addtarget
extension EditQuestionViewController {
    
    func addTarget() {
        editQuestionView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        editQuestionView.redLevelButton.addTarget(self, action: #selector(redLevelButton), for: .touchUpInside)
        editQuestionView.ornageLevelButton.addTarget(self, action: #selector(ornageLevelButton), for: .touchUpInside)
        editQuestionView.blueLevelButton.addTarget(self, action: #selector(blueLevelButton), for: .touchUpInside)
        editQuestionView.questionTitleTextFields.textFields.addTarget(self, action: #selector(questionTitleTextFieldsChanged), for: .allEditingEvents)
        editQuestionView.limitTimeTextFields.textFields.addTarget(self, action: #selector(limitTimeTextFieldsChanged), for: .allEditingEvents)
    }
    
    @objc
    func redLevelButton(sender: UIButton) {
        if !sender.isSelected {
            editQuestionView.ornageLevelButton.isSelected = false
            editQuestionView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
        vm.familarDegree.value = 3
    }
    
    @objc
    func ornageLevelButton(sender: UIButton) {
        if !sender.isSelected {
            editQuestionView.redLevelButton.isSelected = false
            editQuestionView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
        
        vm.familarDegree.value = 6
    }
    
    @objc
    func blueLevelButton(sender: UIButton) {
        if !sender.isSelected {
            editQuestionView.redLevelButton.isSelected = false
            editQuestionView.ornageLevelButton.isSelected = false
            sender.isSelected = true
        }
        
        vm.familarDegree.value = 9
    }
    
    @objc
    func questionTitleTextFieldsChanged() {
        vm.questionTitle.value = editQuestionView.questionTitleTextFields.textFields.text!
    }
    
    
    @objc
    func limitTimeTextFieldsChanged() {
        vm.limitTime.value = editQuestionView.limitTimeTextFields.textFields.text!
    }
    
    @objc
    func addButtonTapped() {
        if isEdited == true {
            vm.updateQuestion()
        } else {
            vm.creatQuestion()
        }
        navigationController?.popViewController(animated: true)
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
            vm.selectedMinutes.value = row
            vm.limitTimeMinutes.value = row
        } else  {
            vm.selectedSeconds.value = row
            vm.limitTimeMinutes.value = row
        }
        
        vm.limitTime.bind { [weak self] value in
            self?.editQuestionView.limitTimeTextFields.textFields.text = value
        }
        

    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if component == 0 {
            let label = UILabel()
            label.text = "\(row)분"
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textAlignment = .center
            label.textColor = UIColor.mainBlue
            return label
            
        } else {
            let label = UILabel()
            label.text = "\(row)초"
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textAlignment = .center
            label.textColor = UIColor.mainBlue
            return label
        }
        
    }
}

extension EditQuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        editQuestionView.folderSelectCollectionView.delegate = self
        editQuestionView.folderSelectCollectionView.dataSource = self
        editQuestionView.folderSelectCollectionView.register(FolderSelectCollectionCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.fetchFolderCnt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FolderSelectCollectionCell else {
            return UICollectionViewCell()
        }
        
        let selectedIndex = selectedIndex
        
        if !selectedIndex.isEmpty {
            vm.isCellSelected.value = true
        }
        cell.setFolderSelectCollectionCell(folders: vm.folders, indexPath: indexPath, selectedIndex: selectedIndex)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        if selectedIndex.contains(row) {
            if let index = selectedIndex.firstIndex(of: row) {
                selectedIndex.remove(at: index)
                selectedIndex.sort { $1 > $0 }
                
            }
        } else {
            selectedIndex.append(row)
            selectedIndex.sort { $1 > $0 }
        }
        
        if selectedIndex.isEmpty {
            vm.isCellSelected.value = false
        }
    
        let realm = try! Realm()
            try! realm.write {
                selectedFoldersList.removeAll()
                for index in selectedIndex {
                    if index < vm.fetchFolderCnt() {
                        let folder = vm.folders[index]
                        selectedFoldersList.append(folder)
                    } else {
                        print("Index out of range error")
                    }
                }
            }
        collectionView.reloadItems(at: [indexPath])
    }
}

extension EditQuestionViewController {
    
    private func setNavigationItem() {
        navigationItem.title = "질문을 설정하세요"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
