//
//  SampleVC.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/30.
//

import UIKit
import AVFoundation
import Speech
import Then

class SampleVC: BaseViewController {
    
    private let audioSession = AVAudioSession.sharedInstance()
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))
    private var audioPlayer: AVAudioPlayer?
    private var recorder = AVAudioRecorder()
    private var isAudioPlaying = false
    
    private let resultTextView = UITextView().then {
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private let recordingButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("녹음", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(recordingButtonTapped), for: .touchUpInside)
    }
    
    private let playButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("재생", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkMicPermission()
    }
    
    override func configure() {
        [resultTextView, recordingButton, playButton].forEach { view.addSubview($0) }

    }
    
    override func layouts() {
        resultTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(300)
        }
        
        recordingButton.snp.makeConstraints { make in
            make.top.equalTo(resultTextView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(resultTextView.snp.bottom).offset(20)
            make.leading.equalTo(recordingButton.snp.trailing).offset(50)
            make.width.equalTo(100)
        }
    }
    
    @objc func recordingButtonTapped() {
        checkSpeechRecognitionPermission()
        
        if audioEngine.isRunning {
            stopRecording()
            recorderSet().stop()
            print("음성 녹음 중지")
        } else {
            startRecording()
            recorderSet().record()
            print("음성 녹음 시작")
        }
        
    }
    
    @objc func playButtonTapped() {
        do {
            
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
                print("음성 재생 중지")
            } else {
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url)
                
                guard let audioPlayer = audioPlayer else {
                    return }
                
                audioPlayer.play()
                print("음성 재생 시작")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        
        }
    
    func recorderSet() -> AVAudioRecorder {
        
        recorder.delegate = self

        do {
            let inputNode = audioEngine.inputNode
            let settings = [
                        AVFormatIDKey: Int(kAudioFormatLinearPCM),
                        AVSampleRateKey: 16000,
                        AVNumberOfChannelsKey: 1,
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                    ]
        
            let filePath = getDocumentsDirectory().appendingPathComponent("recordingFile.wav")

            print("저장 경로", filePath)
            recorder = try AVAudioRecorder(url: filePath, settings: settings )
        
        } catch {
            print(error.localizedDescription)
        }
    
        return recorder
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
                    self?.resultTextView.text = bestTranscription
                    
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
        audioSession.requestRecordPermission { [weak self] _ in
            
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

extension SampleVC:  AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            
        } else {
            
        }
    }
}

