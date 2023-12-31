//
//  CustomTextView.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/06.
//

import UIKit
import SnapKit

class CustomTextView: BaseView {

    lazy var recordedReplyLabel = UILabel().then {
        $0.textColor = .textDarkGrey
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    lazy var resultTextView = UITextView().then {
        let range = NSMakeRange($0.text.count - 1, 0)
        $0.scrollRangeToVisible(range)
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.layer.cornerRadius = 10

    }
    
    init(title: String?) {
        super.init(frame: .zero)
        self.recordedReplyLabel.text = title
        layouts()
        resultTextView.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layouts() {
        addSubview(recordedReplyLabel)
        
        recordedReplyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        addSubview(resultTextView)
        
        resultTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(recordedReplyLabel.snp.bottom).offset(Constant.spacing)
            $0.bottom.equalTo(self)
        }
    }
}
