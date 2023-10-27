//
//  CameraViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import Foundation
import AVFoundation
import RealmSwift

protocol CameraViewModelDelegate: AnyObject {
    func cameraSessionConfigured(session: AVCaptureSession)
    func cameraSessionError(error: Error)
}

class CameraViewModel {
    weak var delegate: CameraViewModelDelegate?
    private let captureSession = AVCaptureSession()
    let repo = CRUDManager.shared
    var objectID = Observable(ObjectId())
    var questions: List<QuestionModel>!
    var folder: Results<FolderModel>!
    var currnetQuestionIndex = Observable(0)
    var familarDegree = Observable(0)
    var limitMinutes = Observable(0)
    var limitSeconds = Observable(0)
    var limitTime = Observable(TimeInterval())
    var limitTimeTxt = Observable("")
    var timer: Timer?
    
    init() {
        setRealm()
        fetchLimitTimeTxt()
    }
    
    func checkCameraAuthorization(completion: @escaping (_ status: AVAuthorizationStatus) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(.authorized)
        case .notDetermined:
            requestCameraAuthorization()
        case .denied, .restricted:
            completion(.denied)
        }
    }
    
    func requestCameraAuthorization() {
           AVCaptureDevice.requestAccess(for: .video) { granted in
               if granted {
                   self.setupFrontCamera()
               } else {
                   return
               }
           }
       }
    
    func setupFrontCamera() {
        if let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                    delegate?.cameraSessionConfigured(session: captureSession)
                }
            } catch {
                delegate?.cameraSessionError(error: error)
            }
        }
    }
    
    func startCaptureSession() {
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    
    func setRealm() {
        objectID.bind { ObjectId in
            self.folder = self.repo.filterByObjcID(object: FolderModel.self, key: "folderID", objectID: ObjectId)
            self.questions = self.folder.first?.questions
        }
    }
    
    func fetchQuestionTitle()-> String {
        let index = currnetQuestionIndex.value
        return questions[index].questionTitle
    }
    
    func fetchFolderTitle()-> String {
        return folder.first?.folderTitle ?? ""
    }
    
    func fetchCurrentFamilarDegree() {
        familarDegree.value = questions[currnetQuestionIndex.value].familiarityDegree
    }
    
    func fetchProgress() -> Float {
        let index = currnetQuestionIndex.value + 1
        let result = Float(index) / Float(questions.count)
        
        return result
    }
    
    func fetchQuestionCnt() -> Int {
        return questions.count
    }
    
    func fetchCurrentIndexTxt() -> String {
        return "\(currnetQuestionIndex.value + 1)번 / \(questions.count)"
    }
    
    func uploadSelectedFamiliarityDegree(value: Int) {
        
        let realm = try! Realm()
        
        try! realm.write {
            questions[currnetQuestionIndex.value].familiarityDegree = value
        }
        
    }
    
    func fetchLimitTime(index: Int){
        limitMinutes.value = questions[index].limitTimeMinutes
        limitSeconds.value = questions[index].limitTimeSeconds
        limitTime.value = TimeInterval(limitMinutes.value * 60 + limitSeconds.value)
    }
    
    func fetchLimitTimeTxt() {
        limitTime.bind { TimeInterval in
            
            if TimeInterval < 0 {
                return
            }
            
            self.limitTimeTxt.value = self.timeIntervalToString(timeInterval: TimeInterval)
        }
    }
    
    func fetchCurrentLimitTime() {
        
        if limitTime.value == 0 {
            return
        }
        
        limitTime.value -= 1
        fetchCurrentLimitTime()
    }
    
    func timeIntervalToString(timeInterval: TimeInterval ) -> String {
        
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
}

