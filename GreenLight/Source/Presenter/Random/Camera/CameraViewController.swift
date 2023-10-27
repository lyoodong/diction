//
//  CameraViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/19.
//

import UIKit
import SnapKit
import AVFoundation

protocol CameraViewModelProtocol: AnyObject {
    var cameraViewModel: CameraViewModel { get }
}

import UIKit
import AVFoundation

class CameraViewController: BaseViewController, CameraViewModelProtocol{
    var cameraViewModel: CameraViewModel
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    let cameraView = CameraView()
    
    
    init(cameraViewModel: CameraViewModel) {
        self.cameraViewModel = cameraViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraViewModel.setRealm()
    }
    
    override func configure() {
        cameraViewModel.delegate = self
        addTarget()
        cameraViewModel.setupFrontCamera()
        cameraViewModel.fetchCurrentFamilarDegree()
        setTabBar()
        setNavigationBar()
    }
    
    override func layouts() {
        view.addSubview(cameraView)
        
        cameraView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        cameraViewModel.currnetQuestionIndex.bind { [weak self] value in
            if let self = self {
                self.cameraView.questionTitleLabel.text = self.cameraViewModel.fetchQuestionTitle()
                cameraViewModel.repo.realmFileLocation()
                self.cameraView.folderTitleLabel.text =
                self.cameraViewModel.fetchFolderTitle()
                self.cameraView.currentIndexProgressBar.progress = self.cameraViewModel.fetchProgress()
                self.cameraView.questionCountLabel.text = self.cameraViewModel.fetchCurrentIndexTxt()
                self.cameraViewModel.fetchLimitTime(index: value)
                checkNextButtonStatus(value: value)
                checkBackButtonStatus(value: value)
            }
        }
        
        func checkNextButtonStatus(value: Int) {
            let questionCnt = cameraViewModel.fetchQuestionCnt()
            if value == questionCnt - 1 {
                cameraView.nextButton.isEnabled = false
            } else {
                cameraView.nextButton.isEnabled = true
            }
        }
        
        func checkBackButtonStatus(value: Int) {
            if value == 0 {
                cameraView.backButton.isEnabled = false
            } else {
                cameraView.backButton.isEnabled = true
            }
        }
        
        cameraViewModel.familarDegree.bind { value in
            if value == 3 {
                self.activeRedLevelButton(sender: self.cameraView.redLevelButton)
            } else if value == 6 {
                self.activeOrangeLevelButton(sender: self.cameraView.ornageLevelButton)
            } else {
                self.activeBlueLevelButton(sender: self.cameraView.blueLevelButton)
            }
            self.cameraViewModel.uploadSelectedFamiliarityDegree(value: value)
        }
        
        cameraViewModel.limitTimeTxt.bind { value in
            self.cameraView.limitTimeLabel.text = "\(value) "
        }
    }
}

extension CameraViewController {
    func setNavigationBar() {
        
        let switchBarButton = UIBarButtonItem(customView: cameraView.cameraSwitchStackView)
        navigationItem.rightBarButtonItem = switchBarButton
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backAction = UIAction(handler: { _ in
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
            self.navigationItem.largeTitleDisplayMode = .always
        })
    }
    
    func setTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
}

extension CameraViewController: CameraViewModelDelegate {
    func cameraSessionConfigured(session: AVCaptureSession) {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        cameraViewModel.startCaptureSession()
    }
    
    func cameraSessionError(error: Error) {
        print("Camera setup error: \(error.localizedDescription)")
    }
}

extension CameraViewController {
    func addTarget() {
        cameraView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        cameraView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        cameraView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        cameraView.redLevelButton.addTarget(self, action: #selector(redLevelButton), for: .touchUpInside)
        cameraView.ornageLevelButton.addTarget(self, action: #selector(ornageLevelButton), for: .touchUpInside)
        cameraView.blueLevelButton.addTarget(self, action: #selector(blueLevelButton), for: .touchUpInside)
        cameraView.cameraSwitchButton.addTarget(self, action: #selector(cameraSwitchButtonTapped), for: .valueChanged)
    }
    
    @objc
    func startButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        setTimer(isSelected: sender.isSelected)
        
        if sender.isSelected {
            cameraView.recordAnimationView.play()
            cameraView.questionView.isHidden = true
            cameraView.emptyText.isHidden = true
            cameraView.emptyAnimationView.isHidden = true
        } else {
            cameraView.recordAnimationView.stop()
            cameraView.questionView.isHidden = false
            cameraView.emptyText.isHidden = false
            cameraView.emptyAnimationView.isHidden = false
        }
    }
    
    func setTimer(isSelected: Bool) {
        if isSelected {
            self.cameraViewModel.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.cameraViewModel.limitTime.value -= 1
                if self.cameraViewModel.limitTime.value == 0 {
                    timer.invalidate()
                }
            }
        } else {
            self.cameraViewModel.timer?.invalidate()
            self.cameraViewModel.timer = nil
        }
    }
    
    
    @objc
    func nextButtonTapped() {
        cameraViewModel.currnetQuestionIndex.value += 1
        cameraViewModel.fetchCurrentFamilarDegree()
    }
    
    @objc
    func backButtonTapped() {
        cameraViewModel.currnetQuestionIndex.value -= 1
        cameraViewModel.fetchCurrentFamilarDegree()
    }
    
    @objc
    func redLevelButton(sender: UIButton) {
        activeRedLevelButton(sender: sender)
        cameraViewModel.familarDegree.value = 3
    }
    
    func activeRedLevelButton(sender:UIButton) {
        if !sender.isSelected {
            cameraView.ornageLevelButton.isSelected = false
            cameraView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @objc
    func ornageLevelButton(sender: UIButton) {
        activeOrangeLevelButton(sender: sender)
        cameraViewModel.familarDegree.value = 6
    }
    
    func activeOrangeLevelButton(sender:UIButton) {
        if !sender.isSelected {
            cameraView.redLevelButton.isSelected = false
            cameraView.blueLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @objc
    func blueLevelButton(sender: UIButton) {
        activeBlueLevelButton(sender: sender)
        cameraViewModel.familarDegree.value = 9
    }
    
    func activeBlueLevelButton(sender:UIButton) {
        if !sender.isSelected {
            cameraView.ornageLevelButton.isSelected = false
            cameraView.redLevelButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @objc
    func cameraSwitchButtonTapped(sender: UISwitch) {
        if sender.isOn {
            cameraView.testView.isHidden = true
            cameraViewModel.checkCameraAuthorization { status in
                if status == .authorized {
                    self.cameraViewModel.setupFrontCamera()
                } else if status == .denied {
                    self.showTwoWayAlert(title: "권한을 변경하시겠습니까?") {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                }
            }
        } else {
            cameraView.testView.isHidden = false
        }
    }
    
    
}




