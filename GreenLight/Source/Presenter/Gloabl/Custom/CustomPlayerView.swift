//
//  CustomPlayerView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/05.
//

import UIKit
import SnapKit
import Then

class CustomPlayerView: BaseView {
    
    lazy var titleLabel = UILabel().then {
        $0.text = "녹음 제목"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    lazy var dateLabel = UILabel().then {
        $0.text = "2023.09.20 목"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var slider = UISlider().then {
        let thumb = UIImage(systemName: "circle.fill")?.withTintColor(.mainBlue!, renderingMode: .alwaysOriginal)
    
        $0.minimumValue = 0
        $0.minimumTrackTintColor = .mainBlue
        $0.maximumTrackTintColor = .bgGrey
        $0.setThumbImage(thumb, for: .normal)
        $0.isContinuous = true
    }
    
    lazy var currentTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .mainBlue
    }
    
    lazy var totalTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = .systemFont(ofSize: 12)
        
    }
    
    lazy var backwardButton = UIButton().then {
        $0.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        $0.tintColor = .black
        
    }
    
    lazy var pauseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.fill"), for: .normal)
        $0.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        $0.tintColor = .white
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 40 / 2
    }
    
    lazy var forwardButton = UIButton().then {
        $0.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        $0.tintColor = .black
    }
    
    override func layouts() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constant.spacing)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.spacing / 2)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(Constant.spacing * 2)
        }
        
        addSubview(slider)
        
        slider.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(Constant.spacing * 2)
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing * 2)
        }
        
        addSubview(currentTimeLabel)
        
        currentTimeLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(Constant.spacing / 2)
            $0.leading.equalTo(slider.snp.leading)
        }
        
        addSubview(totalTimeLabel)
        
        totalTimeLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(Constant.spacing / 2)
            $0.trailing.equalTo(slider.snp.trailing)
        }
        
        let stackView = UIStackView(arrangedSubviews: [backwardButton, pauseButton, forwardButton])
        
        backwardButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        forwardButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        pauseButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        stackView.spacing = 32
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(totalTimeLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
    }

}

extension CustomPlayerView {
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
