//
//  DetailViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/03.
//

import UIKit
import AVFoundation
import Speech
import RealmSwift

class RecordViewController: BaseViewController {
        
    let recordView = RecordView()
    let vm = RecordViewModel()
    
    var isPaused: Bool = false
    
    
    override func loadView() {
        view = recordView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.checkMicPermission {
            self.requestDeniedPermission()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func configure() {
        vm.setRealm()
        vm.setSession()
        setViewData()
        setNavigationItem()
        addTarget()
    }
    
    
    func setViewData() {
        recordView.limitTimeLabel.text = "제한 시간 " + vm.fetchlimitTime()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.recordView.timeLabel.text = self.vm.updateCurrentTime()
        }
    }
}

//MARK: - setNavigationItem
extension RecordViewController {
    private func setNavigationItem() {
        navigationItem.title = vm.fetchQuestionTitle()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - addTarget
extension RecordViewController {
    
    func addTarget() {
        recordView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        recordView.recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        recordView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func cancelButtonTapped() {
        
        let alert = UIAlertController(title: "저장하지 않겠습니까?", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "취소", style: .cancel)
        let cancel = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.vm.audioEngine.reset()
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc
    func recordButtonTapped() {
        vm.checkSpeechRecognitionPermission {
            self.showSpeechRecognitionPermissionAlert()
        }
        if vm.isFirst {
            vm.isFirst.toggle()
            vm.startRecording()
            startRecognition()
            updateRecordAnimationView(isPlay: true)

        } else {
            if vm.audioEngine.isRunning {
                isPaused = true
                vm.pauseRecording()
                vm.pauseRecognition()
                updateRecordAnimationView(isPlay: false)
            } else {
                isPaused.toggle()
                vm.resumeRecording()
                vm.resumeRecognition()
                updateRecordAnimationView(isPlay: true)
            }
        }
    }
    
    func updateRecordAnimationView(isPlay: Bool) {
        if isPlay {
            recordView.recordAnimationView.play()
        } else {
            recordView.recordAnimationView.stop()
        }
        
    }
    @objc
    func saveButtonTapped() {
        guard let recordedText = recordView.resultTextView.text else {
            return
        }
        let objtID = vm.saveRecordingData(recordedText: recordedText)
        
        if isPaused {
            vm.audioRecorder.record()
            vm.stopRecognition()
            vm.stopRecording()
        } else {
            vm.stopRecognition()
            vm.stopRecording()
            
        }
    
        let vc = DetailViewController()
        vc.vm.answerID = objtID
        vc.vm.audioUrl = vm.audioRecorder.url
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Speech Recognize

extension RecordViewController {
    
    func startRecognition()   {
        vm.fetchRecognition(convertedText: { resultText in
            self.recordView.resultTextView.text = resultText
        })
    }
}

//MARK: - Recording


//MARK: - Check Permission
extension RecordViewController {

    func requestDeniedPermission() {
        let alert = UIAlertController(
            title: "마이크 권한 요청",
            message: "마이크 권한이 필요합니다. 설정에서 권한을 활성화해주세요.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    func showSpeechRecognitionPermissionAlert() {
        let alert = UIAlertController(
            title: "음성 인식 권한 요청",
            message: "음성 인식을 사용하려면 권한이 필요합니다. 설정에서 권한을 활성화해주세요.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        present(alert, animated: true)
    }
}

                
