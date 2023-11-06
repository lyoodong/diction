//
//  EditNameViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import Foundation

class EditNameViewController: BaseViewController, EditNameViewModelProtocol {
    
    let editNameViewModel: EditNameViewModel
    let editNameView = EditNameView()
    
    init(editNameViewModel: EditNameViewModel) {
        self.editNameViewModel = editNameViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = editNameView
    }
    
    override func configure() {
        addTarget()
    }
    
    override func bind() {
        editNameViewModel.nickNameText.bind { [weak self] value in
            if let buttonIsEnabled = self?.editNameViewModel.checkButtonStatus() {
                if buttonIsEnabled {
                    self?.editNameView.saveButton.backgroundColor = .mainBlue
                } else {
                    self?.editNameView.saveButton.backgroundColor = .mainBlue?.withAlphaComponent(0.5)
                }
                self?.editNameView.saveButton.isEnabled = buttonIsEnabled
            }
        }
    }
}

extension EditNameViewController {
    func addTarget() {
        editNameView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        editNameView.eidtTextField.addTarget(self, action: #selector(eidtTextFieldChnaged), for: .editingChanged)
    }
    
    @objc
    func saveButtonTapped() {
        do {
            try editNameViewModel.checkValidation()
            let nickName = editNameViewModel.nickNameText.value
            
            let defaults = UserDefaults.standard
            defaults.set(nickName, forKey: "nickName")
            navigationController?.popViewController(animated: true)
        } catch {
            switch error {
            case nickNameError.emptyText:
                editNameView.eidtTextField.errorMessage = "빈 텍스트 입니다."
            case nickNameError.exceededText:
                editNameView.eidtTextField.errorMessage = "글자 수는 8자 이하로 설정해주세요"
            case nickNameError.numberText:
                editNameView.eidtTextField.errorMessage = "숫자만 입력할 수 없습니다."
            case nickNameError.spaceInText:
                editNameView.eidtTextField.errorMessage = "공백을 포함할 수 없습니다."
            default:
                editNameView.eidtTextField.errorMessage = "다시 시도해주세요."
            }
        }
    }
    
    @objc
    func eidtTextFieldChnaged() {
        if let text = editNameView.eidtTextField.text {
            editNameViewModel.nickNameText.value = text
            editNameView.eidtTextField.errorMessage = nil
        }
    }
}
