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
    
    private let audioSession = AVAudioSession.sharedInstance()
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko_KR"))
    private var audioRecorder = AVAudioRecorder()
    private var audioFile: AVAudioFile?
    private var audioFileURL: URL?
    private var audioPlayer = AVAudioPlayer()
    private var timer = Timer()
    
    var isFirst: Bool = true
    private var previousText: String = ""
    let recordView = RecordView()
    var answerID = UUID().uuidString
    
    var questionID = ObjectId()
    var question:  Results<QuestionModel>!
    let repo = CRUDManager.shared
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkMicPermission()
    }
    
    override func configure() {
        setNavigationItem()
        addTarget()
        setSession()
        updateTime()
        recordView.resultTextView.addShadow()
    }
    
    private func updateTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            let currentTime = self.audioRecorder.currentTime
            self.recordView.timeLabel.text = self.formatTime(seconds: currentTime)
        }
    }
}

//MARK: - setNavigationItem
extension RecordViewController {
    
    private func setNavigationItem() {
        
        let question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
        recordView.limitTimeLabel.text = "제한 시간 " + (question.first?.limitTimeToString ?? "")
        recordView.interviewDateLabel.isHidden = true
        navigationItem.title = question.first?.questionTitle
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 26)]
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = true
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
            beginRecording()
            print("녹음 시작")
            recordView.recordAnimationView.play()

        } else {
            if audioEngine.isRunning {
                stopRecording()
                pauseRecording()
                print("녹음 일시 중지")
                recordView.recordAnimationView.stop()
            } else {
                startRecording()
                resumeRecording()
                print("녹음 재개")
                recordView.recordAnimationView.play()
            }
        }
    }
    
    @objc
    func saveButtonTapped() {
        saveRecording()
        stopRecording()
        
        let vc = DetailViewController()
        vc.audioUrl = audioRecorder.url

        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioRecorder.url)
        } catch {
            print("audioPlayer 재생 오류: \(error)")
        }
        
        let answeringTime = audioPlayer.duration
        
        let url = try? String(contentsOf: audioRecorder.url)
        
        if let recordText = recordView.resultTextView.text {
            let objc = AnswerModel(answerID: answerID, recordText: recordText, creationDate: Date(), answeringTime: answeringTime, recordUrl: "\(audioRecorder.url)", questionID: questionID)
            repo.write(object: objc)
            vc.answerID = objc.answerID
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - AVAudioRecorderDelegate
extension RecordViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully.")
        } else {
            print("Recording failed.")
        }
    }
    
}

//MARK: - Speech Recognize

extension RecordViewController {
    
    func stopRecording() {
        recognitionRequest.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        previousText = recordView.resultTextView.text
    }
    
    enum audioError:Error {
        case sessionUnavailable
        case engineUnavailable
    }
    
    func startRecording()   {
        
        do {
            try setAudioEngine(completion: { [weak self] result in
                self?.recordView.resultTextView.text = (self?.previousText ?? "") + " " + result
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
   
    func setSession()  {
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
//            throw audioError.sessionUnavailable
        }
        
    }
    
    func setAudioEngine(completion: @escaping (String) -> Void) throws {
        
        do {
            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest.append(buffer)
            }
            recognitionRequest.shouldReportPartialResults = true
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] response, error in
                
                if response != nil {
                    
                    if let response = response {
                        let bestTranscription = response.bestTranscription
                        let recoginitionResult = bestTranscription.formattedString
                        completion(recoginitionResult)
                        
                    }
                    
                } else if let error = error {
                    print("음성 인식 오류: \(error.localizedDescription)")
                    self?.audioEngine.reset()
                    return
                }
                
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            
        } catch {
            throw audioError.engineUnavailable
        }
    }
}

//MARK: - Recording
extension RecordViewController {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func beginRecording() {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(answerID).m4a")
        print(getDocumentsDirectory())
        
        audioFileURL = audioFilename
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            print("Recording setup error: \(error.localizedDescription)")
        }
    }
    
    func formatTime(seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        let seconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func pauseRecording() {
        if audioRecorder.isRecording {
            audioRecorder.pause()
        }
    }
    
    func resumeRecording() {
        if audioRecorder.isRecording == false {
            audioRecorder.record()
        }
    }
    
    func saveRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
        }
    }
}


//MARK: - Check Permission
extension RecordViewController {
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

//                    let speakingRate = response.speechRecognitionMetadata?.speakingRate
//                    let averagePauseDuration = response.speechRecognitionMetadata?.averagePauseDuration
//                    let voiceAnalytics = response.speechRecognitionMetadata?.voiceAnalytics
//                    let voicing = voiceAnalytics?.voicing
//                    let pitch = voiceAnalytics?.pitch
//                    let jitter = voiceAnalytics?.jitter
//                    let shimmer = voiceAnalytics?.shimmer
//
//                    print("=====speakingRate통계", speakingRate)
//                    print("=====averagePauseDuration통계", averagePauseDuration)
//                    print("=====voiceAnalytics통계", voiceAnalytics)
//                    print("=====voicing통계", voicing)
//                    print("=====pitch통계", pitch)
//                    print("=====jitter통계", jitter)
//                    print("=====shimmer통계", shimmer)

