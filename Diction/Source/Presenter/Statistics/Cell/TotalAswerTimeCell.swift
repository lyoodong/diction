//
//  TotalAswerTimeCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/27.
//

import UIKit

class TotalAswerTimeCell: BaseCollectionViewCell {
        
    lazy var totalAnswerTimeTitleLabel = UILabel().then {
        $0.text = "주간 학습량"
        $0.textColor = .textDarkGrey
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    lazy var totalAnswerTimeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
    lazy var weekPeriodButton: UIButton = UIButton().then {
        $0.setTitle(Date().convertWeekToString, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.setTitleColor(.textDarkGrey, for: .normal)
        $0.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        backgroundColor = .clear
    }
        
    override func layout() {
    
        let spacing = LayoutSpacing()
    
        addSubview(totalAnswerTimeTitleLabel)
        
        totalAnswerTimeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(spacing.multipleSpacing(2))
            $0.leading.equalTo(spacing.multipleSpacing(3))
        }
        
        addSubview(totalAnswerTimeLabel)
        totalAnswerTimeLabel.snp.makeConstraints {
            $0.top.equalTo(totalAnswerTimeTitleLabel.snp.bottom).offset(spacing.multipleSpacing(1))
            $0.leading.equalTo(spacing.multipleSpacing(3))
        }
        
        addSubview(weekPeriodButton)
        weekPeriodButton.snp.makeConstraints {
            $0.top.equalTo(totalAnswerTimeLabel.snp.bottom).offset(spacing.multipleSpacing(2))
            $0.leading.equalTo(spacing.multipleSpacing(3))
            $0.height.equalTo(spacing.multipleSpacing(4))
        }
    }
    
    func setCell(totalAnswerTime: TimeInterval) {
        let answeringTime = Int(totalAnswerTime)
        let hours = answeringTime / 3600
        let minutes = (answeringTime % 3600) / 60
        let seconds = answeringTime % 60
        let formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        self.totalAnswerTimeLabel.text = formattedTime

    }
}
