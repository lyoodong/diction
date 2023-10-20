//
//  EditFolderViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import UIKit

class EditFolderViewController: BaseViewController {
    
    let editFolderView = EditFolderView()
    let vm = EditFolderViewModel()
    var isEdited = false
        
    override func loadView() {
        view = editFolderView
    }
    
    override func configure() {
        addTarget()
        setNavigationItem()
        setViewData()
    }
    
    func setViewData() {
        
        vm.folderTitle.bind { [weak self] value in
            self?.editFolderView.folderTitleTextFields.textFields.text = value
            self?.vm.checkButtonState()
        }

        vm.interviewDate.bind { [weak self] value in
            self?.editFolderView.datePicker.date = value
            self?.vm.checkButtonState()
        }
        
        vm.isButtonEnabled.bind { [weak self] isEnabled in
            self?.editFolderView.addButton.isEnabled = isEnabled
            self?.editFolderView.addButton.backgroundColor = isEnabled ? .mainBlue : .mainBlue?.withAlphaComponent(0.5)
        }
        
        vm.folder.bind { [weak self] value in
            if !value.folderTitle.isEmpty {
                self?.editFolderView.folderTitleTextFields.textFields.placeholder = value.folderTitle
            }
        }
    }
}

extension EditFolderViewController {
    
    func setNavigationItem() {
        navigationController?.navigationBar.tintColor = .mainBlue
    }
    
    func addTarget() {
        editFolderView.folderTitleTextFields.textFields.addTarget(self, action: #selector(textFieldsChanged), for: .allEditingEvents)
        editFolderView.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        editFolderView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func datePickerValueChanged() {
        vm.interviewDate.value = editFolderView.datePicker.date
    }
    
    @objc func addButtonTapped() {
        
        
        if isEdited {
            vm.updateFolder()
        } else {
            vm.createFolder()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldsChanged() {
        if let text = editFolderView.folderTitleTextFields.textFields.text {
            vm.folderTitle.value = text
            
        }
    }
}
