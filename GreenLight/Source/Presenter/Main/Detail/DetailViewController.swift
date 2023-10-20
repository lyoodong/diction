//
//  DetailReplyViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/05.
//

import UIKit
import AVFAudio
import SnapKit

class DetailViewController: BaseViewController {
    
    let detailview = DetailView()
    let vm = DetailViewModel()
    
    override func loadView() {
        view = detailview
    }
    
    override func configure() {
        vm.setRealm()
        vm.setAudioPlayer()
        setNavigationItem()
        setViewData()
        addTarget()
    }
}

extension DetailViewController {
    
    private func setViewData() {
//        detailview.interviewDateLabel.text = vm.fetchAnsweringTime()
        detailview.resultTextView.text = vm.fetchRecordText()
        detailview.customPlayerView.totalTimeLabel.text = vm.formatTime(seconds: vm.audioPlayer.duration)
        
        detailview.customPlayerView.dateLabel.text = vm.fetchCreationDateSimple()
        
        detailview.customLevelStackView.isHidden = true
        detailview.interviewDateLabel.isHidden = true
    }
    
    private func setNavigationItem() {
        navigationItem.title = vm.fetchCreationDate() + "녹음"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backAction = UIAction(handler: { _ in
            guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                for viewController in viewControllerStack {
                    if let vc = viewController as? DetailReplyViewController {
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
        })
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func updatePlayButtonUI() {
        detailview.customPlayerView.pauseButton.isSelected = vm.isPlaying
    }
    
    private func updateTimeLabels() {
        let currentTime = vm.audioPlayer.currentTime
        detailview.customPlayerView.currentTimeLabel.text = vm.formatTime(seconds: currentTime)
    }
    
    private func startSliderUpdateTimer() {
        vm.timer = Timer.scheduledTimer(timeInterval: 0.0000001, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    private func stopSliderUpdateTimer() {
        vm.timer?.invalidate()
        vm.timer = nil
    }
    
}

extension DetailViewController {
    
    private func addTarget() {
        detailview.customPlayerView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.backwardButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        detailview.customPlayerView.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

    }
    
    @objc
    private func backButtonTapped() {
        let currentTime = vm.audioPlayer.currentTime
        let newTime = currentTime - 10
        vm.audioPlayer.currentTime = max(newTime, 0)
        updateTimeLabels()
        startSliderUpdateTimer()
    }
    
    @objc
    private func pauseButtonTapped(sender: UIButton) {
        
        if  vm.isPlaying {
            vm.audioPlayer.pause()
            stopSliderUpdateTimer()
            print("중지")
        } else {
            vm.audioPlayer.play()
            startSliderUpdateTimer()
            print("재생")
        }
        
        vm.isPlaying.toggle()
        updatePlayButtonUI()
        
    }
    
    @objc
    private func forwardButtonTapped() {
        let currentTime = vm.audioPlayer.currentTime
        let newTime = currentTime + 5
        vm.audioPlayer.currentTime = min(newTime, vm.audioPlayer.duration)
        updateTimeLabels()
        startSliderUpdateTimer()
    }
    
    @objc
    private func sliderValueChanged() {
        
        vm.audioPlayer.pause()
        let currentTime = Double(detailview.customPlayerView.slider.value) * vm.audioPlayer.duration
        vm.audioPlayer.currentTime = currentTime

        updateTimeLabels()
        
        if vm.isPlaying {
            vm.audioPlayer.play()
        }
    }
    
    @objc
    private func updateSlider() {
        detailview.customPlayerView.slider.value = Float( vm.audioPlayer.currentTime / vm.audioPlayer.duration)
        updateTimeLabels()
    }
}
