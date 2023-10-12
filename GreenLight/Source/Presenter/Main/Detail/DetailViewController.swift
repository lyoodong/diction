//
//  DetailReplyViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/05.
//

import UIKit
import AVFAudio
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    let detailview = DetailView()
    
    var audioPlayer = AVAudioPlayer()
    
    var audioUrl: URL? = nil
    
    var isPlaying: Bool = false
    
    var timer: Timer?
    
    var answerID = ""
    
    var answer: Results<AnswerModel>!
    
    let repo = CRUDManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        setAudioPlayer()
        detailview.resultTextView.text = answer[0].recordText
        detailview.resultTextView.addShadow()
    }
    
    override func loadView() {
        view = detailview
    }
    
    override func configure() {
        answer = repo.filterByObjcID(object: AnswerModel.self, key: "answerID", objectID: answerID)
        setNavigationItem()
        addTaget()
        
        detailview.interviewDateLabel.text = answer.first?.answeringTimeToString
        
    }
    
    func setAudioPlayer() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("AVAudioSession 설정 중 오류 발생: \(error)")
        }


        if let audioUrl = URL(string: answer[0].recordUrl) {

            do {
                print(audioUrl)
                audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
                detailview.customPlayerView.totalTimeLabel.text = formatTime(seconds: audioPlayer.duration)
            } catch {
                print("audioPlayer 재생 오류: \(error)")
            }
        }
    }
    
    func addTaget() {
        detailview.customPlayerView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.backwardButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    @objc func sliderValueChanged() {
        
        audioPlayer.pause()
        let currentTime = Double(detailview.customPlayerView.slider.value) * audioPlayer.duration
        audioPlayer.currentTime = currentTime
        
        // 현재 시간을 표시하는 레이블을 업데이트합니다.
        updateTimeLabels()
        
        if isPlaying {
            audioPlayer.play()
        }
    
    }

    func startSliderUpdateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.0000001, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    func stopSliderUpdateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateSlider() {
        detailview.customPlayerView.slider.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        updateTimeLabels()
    }

    @objc
    func pauseButtonTapped(sender: UIButton) {
        
        if isPlaying {
            audioPlayer.pause()
            stopSliderUpdateTimer()
            print("중지")
        } else {
            audioPlayer.play()
            startSliderUpdateTimer()
            print("재생")
        }
        
        isPlaying.toggle()
        updatePlayButtonUI()
        
    }
    
    func updatePlayButtonUI() {
        if isPlaying {
            detailview.customPlayerView.pauseButton.isSelected = true
        } else {
            detailview.customPlayerView.pauseButton.isSelected = false
        }
    }
    
    @objc func backButtonTapped() {
        let currentTime = audioPlayer.currentTime
        let newTime = currentTime - 10
        audioPlayer.currentTime = max(newTime, 0)
        updateTimeLabels()
        startSliderUpdateTimer()
    }
    
    @objc func forwardButtonTapped() {
        let currentTime = audioPlayer.currentTime
        let newTime = currentTime + 10
        audioPlayer.currentTime = min(newTime, audioPlayer.duration)
        updateTimeLabels()
        startSliderUpdateTimer()
    }
    
    func updateTimeLabels() {
        let currentTime = audioPlayer.currentTime
        detailview.customPlayerView.currentTimeLabel.text = formatTime(seconds: currentTime)
    }
    
    func formatTime(seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        let seconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension DetailViewController {
    
    private func setNavigationItem() {
        
        navigationItem.title = (answer.first?.creationDate.detailDateFormatter)! + "녹음"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 26)]
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
        
    }
    
}

extension DetailViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
}




