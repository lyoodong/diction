//
//  DetailViewModel.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/11.
//

import Foundation
import AVFAudio
import RealmSwift

class  DetailViewModel {

    var answer: Results<AnswerModel>!
    var answerID = ""
    let repo = CRUDManager.shared
    var audioUrl: URL? = nil
    var audioPlayer = AVAudioPlayer()
    var isPlaying: Bool = false
    var timer: Timer?
    
    func setRealm() {
        answer = repo.filterByObjcID(object: AnswerModel.self, key: "answerID", objectID: answerID)
    }
    
    func fetchAnsweringTime() -> String {
        return answer.first?.answeringTimeToString ?? ""
    }
    
    func fetchRecordText() -> String {
        return answer.first?.recordText ?? ""
    }
    
    func fetchRecordUrl() -> String {
        return answer.first?.recordUrl ?? ""
    }
    
    func fetchCreationDate() -> String {
        return answer.first?.creationDate.detailDateFormatter ?? ""
    }
    
    func formatTime(seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        let seconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setAudioPlayer() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("AVAudioSession 설정 중 오류 발생: \(error)")
        }
        
        print(URL(string: fetchRecordUrl()))

        if let audioUrl = URL(string: fetchRecordUrl()) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                audioPlayer.prepareToPlay()

            } catch {
                print("audioPlayer 생성 오류: \(error)")
            }
        }
    }
}

