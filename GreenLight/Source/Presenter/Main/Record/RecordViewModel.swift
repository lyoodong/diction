//
//  RecordViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/12.
//

import Foundation
import Speech
import AVFoundation
import RealmSwift

class RecordViewModel {
    
    let repo = CRUDManager.shared
    var questionID = ObjectId()
    var question:  Results<QuestionModel>!
    var answerID = UUID().uuidString
    
    var isFirst: Bool = true
    var previousText: String = ""
    
    let audioSession = AVAudioSession.sharedInstance()
    let audioEngine = AVAudioEngine()
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier:"ko-KR"))
    var audioRecorder = AVAudioRecorder()
    var audioFile: AVAudioFile?
    var audioFileURL: URL!
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var speechRecognition: SFSpeechRecognitionResult?
    
    func setRealm() {
        question = repo.filterByObjcID(object: QuestionModel.self, key: "questionID", objectID: questionID)
    }
    
    func fetchlimitTime() -> String {
        return question.first?.limitTimeToString ?? ""
    }
    
    func fetchQuestionTitle() -> String {
        return question.first?.questionTitle ?? ""
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func creatAudioFileURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("\(answerID).m4a")
    }
    
    func formatTime(seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        let seconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateCurrentTime() -> String {
        let currentTime = self.audioRecorder.currentTime
        return formatTime(seconds: currentTime)
        
    }
    
    enum audioError:Error {
        case sessionUnavailable
        case engineUnavailable
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
                        if response.isFinal {
                            
                            let metaData = response.speechRecognitionMetadata
                            
                            if let speakingRate = metaData?.speakingRate {
                                print("=====음성속도 통계", speakingRate)
                            }
                            if let averagePauseDuration = metaData?.averagePauseDuration {

                                print("=====평균 일시정지 시간 통계", averagePauseDuration)
                            }
                            
                            if let speechDuration = metaData?.speechDuration {
                                print("=====전체 시간 중 말한 시간 통계", speechDuration)
                            }

                            if let voiceAnalytics = metaData?.voiceAnalytics {
                                print("=====음성 분석 통계", voiceAnalytics)
                                print("=====음질 통계", voiceAnalytics.voicing)
                                print("=====음높이 통계", voiceAnalytics.pitch)
                                print("=====음 불안정성 통계", voiceAnalytics.jitter)
                                print("=====음성의 진동 빈도 변동을 시각화한 그래프 또는 숫자 통계", voiceAnalytics.shimmer)
                            }
                        }
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
    
    func fetchSpeechRecognitionStatics() {
        
        print("fetchSpeechRecognition, 함수진입")
        
        let metaData = speechRecognition?.speechRecognitionMetadata
        
        if let speakingRate = metaData?.speakingRate {
            print("=====음성속도 통계", speakingRate)
        }


        if let averagePauseDuration = metaData?.averagePauseDuration {
            print("=====평균 일시정지 시간 통계", averagePauseDuration)
        }
        
        if let speechDuration = metaData?.speechDuration {
            print("=====전체 시간 중 말한 시간 통계", speechDuration)
        }

        if let voiceAnalytics = metaData?.voiceAnalytics {
            print("=====음성 분석 통계", voiceAnalytics)
            print("=====음질 통계", voiceAnalytics.voicing)
            print("=====음높이 통계", voiceAnalytics.pitch)
            print("=====음 불안정성 통계", voiceAnalytics.jitter)
            print("=====음성의 진동 빈도 변동을 시각화한 그래프 또는 숫자 통계", voiceAnalytics.shimmer)
        }
        
    }
    
    func fetchRecognition(convertedText: @escaping (String) -> Void)   {
        do {
            try setAudioEngine(completion: {result in
                convertedText(result)
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
    
    func resumeRecognition() {
        do {
            try audioEngine.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pauseRecognition() {
        audioEngine.pause()
    }
    
    func stopRecognition() {
        fetchSpeechRecognitionStatics()
        recognitionRequest.endAudio()
        recognitionTask?.finish()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    func startRecording() {
        audioFileURL = creatAudioFileURL()
        
        let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderBitRateKey: 32000,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]


        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder.record()
        } catch {
            print("Recording setup error: \(error.localizedDescription)")
        }
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
    
    func stopRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
        }
    }
    
    func saveRecordingData(recordedText:String) -> String{
        
        let answeringTime = audioRecorder.currentTime
        print("answeringTime",answeringTime)
        let objc = AnswerModel(answerID: answerID, recordText: recordedText, creationDate: Date(), answeringTime: answeringTime, recordUrl: "\(audioRecorder.url)", questionID: questionID)
        repo.write(object: objc)
        
        return objc.answerID
    }
    
    func checkMicPermission(requestAlertCompletion: @escaping () -> Void) {
        let micPermissionStatus = audioSession.recordPermission
        
        switch micPermissionStatus {
        case .undetermined:
            print("undetermined")
            requestMicPermission()
        case .denied:
            print("denied")
            requestAlertCompletion()
        case .granted:
            print("granted")
            break
        @unknown default:
            fatalError()
        }
    }
    
    func requestMicPermission() {
        audioSession.requestRecordPermission { _ in }
    }
    
    
    func checkSpeechRecognitionPermission(requestAlertCompletion: @escaping () -> Void) {
        
        let speechRecognizerStatus = SFSpeechRecognizer.authorizationStatus()
        
        switch speechRecognizerStatus {
        case .notDetermined:
            requestSpeechRecognitionPermission()
        case .denied:
            requestAlertCompletion()
        case .restricted:
            break
        case .authorized:
            break
        @unknown default:
            fatalError()
        }
        
    }
    
    func requestSpeechRecognitionPermission() {
        SFSpeechRecognizer.requestAuthorization { _ in }
    }
}



