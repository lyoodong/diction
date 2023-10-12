//
//  EditFolderViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/08.
//

import Foundation

class EditFolderViewController: BaseViewController {
    
    let editFolderView = EditFolderView()
    var interviewDate: Date?
    let repo = CRUDManager.shared
    
    override func loadView() {
        view = editFolderView
    }
    
    override func configure() {
        addTarget()
    }
}

extension EditFolderViewController {
    
    func addTarget() {
        editFolderView.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        editFolderView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func datePickerValueChanged() {
        interviewDate = editFolderView.datePicker.date
    }
    
    @objc func addButtonTapped() {
        guard let title = editFolderView.questionTitleTextFields.textFields.text, let interviewDate = interviewDate  else {
            return
        }
        let objc = FolderModel(folderTitle: title, interviewDate: interviewDate)
        repo.write(object: objc)
        navigationController?.popViewController(animated: true)
    }
}
