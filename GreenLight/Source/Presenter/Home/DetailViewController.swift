//
//  DetailViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/03.
//

import UIKit
import AVFoundation
import Speech

class DetailViewController: BaseViewController {
    
    private let audioSession = AVAudioSession.sharedInstance()
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))
    private var audioPlayer: AVAudioPlayer?
    private var recorder = AVAudioRecorder()
    private var isAudioPlaying = false
    
    private var isRecording = false
    private var previousText = ""
    
    
    let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkMicPermission()
    }
    
    override func viewSet() {
        addTarget()
    }
    
    func addTarget() {
        detailView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        detailView.recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func cancelButtonTapped() {
        
        let alert = UIAlertController(title: "저장하지 않겠습니까?", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "취소", style: .cancel)
        let cancel = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.audioEngine.reset()
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc
    func recordButtonTapped() {
        checkSpeechRecognitionPermission()
    
        if isRecording {
            stopRecording()
            print("녹음 중지")
        } else {
            startRecording()
            print("녹음 시작")
        }
        
        isRecording.toggle()
    }
    
    @objc
    func saveButtonTapped() {
        stopRecording()
        print("녹음 시작")
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }

    
    func startRecording() {
    
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            guard let recognitionRequest = recognitionRequest else {
                print("recognitionRequest 초기화 실패")
                return
            }
            
            recognitionRequest.shouldReportPartialResults = true
            
            let inputNode = audioEngine.inputNode
            
            guard let speechRecognizer = speechRecognizer else {
                print("speechRecognizer 초기화 실패")
                return
            }
            
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] response, error in
                if let error = error {
                    print("음성 인식 오류: \(error.localizedDescription)")
                    return
                }
                
                if let response = response {
                    let bestTranscription = response.bestTranscription.formattedString
                    self?.detailView.resultTextView.text = bestTranscription
                    
                }
                
                if response?.isFinal == true {
                    self?.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self?.recognitionRequest = nil
                    self?.recognitionTask = nil
                }
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest?.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
        } catch {
            printContent("startRecording 실패")
        }
    }
    
    // 마이크 권한 체크
    func checkMicPermission() {
        let micPermissionStatus = audioSession.recordPermission
        
        switch micPermissionStatus {
        case .undetermined:
            print("undetermined")
            requestMicPermission()
        case .denied:
            print("denied")
            requestDeniedPermission()
        case .granted:
            print("granted")
            break
        @unknown default:
            fatalError()
        }
    }
    
    // 마이크 권한을 요청
    func requestMicPermission() {
        audioSession.requestRecordPermission { _ in
            
        }
    }
    
    // 마이크 권한이 거부된 경우 재요청
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
    
    func checkSpeechRecognitionPermission() {
        
        let speechRecognizerStatus = SFSpeechRecognizer.authorizationStatus()
        
        switch speechRecognizerStatus {
        case .notDetermined:
            print("notDetermined")
            requestSpeechRecognitionPermission()
        case .denied:
            print("denied")
            showSpeechRecognitionPermissionAlert()
        case .restricted:
            print("restricted")
            break
        case .authorized:
            print("authorized")
            break
        @unknown default:
            fatalError()
        }
        
    }
    
    func requestSpeechRecognitionPermission() {
        SFSpeechRecognizer.requestAuthorization {  _ in
            
        }
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

extension DetailViewController:  AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            
        } else {
            
        }
    }
}


