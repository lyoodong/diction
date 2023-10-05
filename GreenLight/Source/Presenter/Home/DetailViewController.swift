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
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))
    
    private var audioPlayer: AVAudioPlayer?
    private var recorder = AVAudioRecorder()
    
    var isFirst: Bool = true
    private var previousText: String = ""
    
    
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
        recognitionRequest.shouldReportPartialResults = true
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
        
        if isFirst {
            isFirst.toggle()
            startRecording()
            print("녹음 시작")
        } else {
            if audioEngine.isRunning {
                stopRecording()
                print("녹음 일시 중지")
            } else {
                startRecording()
                print("녹음 재개")
            }
        }
    }
    
    
    @objc
    func saveButtonTapped() {
        
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest.endAudio()
        recognitionTask?.cancel()
        previousText = detailView.resultTextView.text
    }
    
    enum audioError:Error {
        case sessionUnavailable
        case engineUnavailable
    }
    
    enum startType {
        case firstStart
        case resumeStart
    }
    
    func startRecording()   {
        
        do {
            try setSession()
            try setAudioEngine(completion: { [weak self] result in
                self?.detailView.resultTextView.text = " " + (self?.previousText ?? "") + result
            })
        } catch {
            switch error {
            case audioError.sessionUnavailable:
                print("audioError.sessionUnavailable")
            case audioError.engineUnavailable:
                print("audioError.engineUnavailable")
            default:
                print("알 수 없는 에러 발생")
            }
        }
        
    }
    
    
    
    func setSession() throws {
        do {
            try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw audioError.sessionUnavailable
        }
        
    }
    
    func setAudioEngine(completion: @escaping (String) -> Void) throws {
        
        do {
            let inputNode = audioEngine.inputNode
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest.append(buffer)
            }
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] response, error in
                if let error = error {
                    print("음성 인식 오류: \(error.localizedDescription)")
                    self?.audioEngine.reset()
                    return
                }
                
                if let response = response {
                    let bestTranscription = response.bestTranscription
                    let recoginitionResult = bestTranscription.formattedString
                    completion(recoginitionResult)
                }
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            
        } catch {
            throw audioError.engineUnavailable
        }
    }
    
    //    func startRecording() {
    //
    //        do {
    //            try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
    //            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    //
    //            let inputNode = audioEngine.inputNode
    //
    //            let recordingFormat = inputNode.outputFormat(forBus: 0)
    //            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
    //                self.recognitionRequest.append(buffer)
    //            }
    //
    //            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] response, error in
    //                if let error = error {
    //                    print("음성 인식 오류: \(error.localizedDescription)")
    //                    self?.audioEngine.reset()
    //                    return
    //                }
    //
    //                if let response = response {
    //                    let bestTranscription = response.bestTranscription
    //                    self?.detailView.resultTextView.text = bestTranscription.formattedString
    //                }
    //            }
    //
    //            audioEngine.prepare()
    //            try audioEngine.start()
    //
    //
    //        } catch {
    //            printContent("startRecording 실패")
    //        }
    //    }
    
    
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

//func pauseRecording() {
//    audioEngine.pause()
//}
