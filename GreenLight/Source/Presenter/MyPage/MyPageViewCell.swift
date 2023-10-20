//
//  MyPageViewCell.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/18.
//

import UIKit

class MyPageViewCell: UITableViewCell {
    lazy var logoImgae = UIImageView().then {
        $0.image = UIImage(assetName: .LogoBig)
    }
    
    lazy var dotView = UIView().then {
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 4
    }
    
    lazy var ellipsisButton: UIButton = UIButton().then {
        let image = UIImage(systemName: "ellipsis")
        $0.setImage(image, for: .normal)
        $0.tintColor = UIColor.systemGray
        $0.isEnabled = false
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        let vc = EditNameViewController(editNameViewModel: EditNameViewModel())
        layouts()
    }
    
    override func prepareForReuse() {
        textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layouts() {
        
        let trailing:CGFloat = -Constant.spacing * 3
        addSubview(ellipsisButton)
        
        ellipsisButton.snp.makeConstraints {
            
            $0.trailing.equalTo(trailing)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(dotView)
        
        dotView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(8)
            $0.size.equalTo(8)
        }
    }
    
    let personalSetting = ["닉네임 변경하기"]
    let AppService = ["문의하기","개인정보처리방침"]
    let designBy = [ "개발", "디자인"]
    let designByImage = [
        UIImage(assetName: .github)?.withTintColor(.black, renderingMode: .alwaysOriginal),
        UIImage(assetName: .behance)?.withTintColor(.black, renderingMode: .alwaysOriginal)
    ]

    func setCell(indexPath: IndexPath) {
        let section = indexPath.section
        
        if section == 0 {
            dotView.isHidden = false
            ellipsisButton.isHidden = true
            var nickName = (UserDefaults.standard.string(forKey: "nickName") ?? "익명") + "님"
            imageView?.image = nil
            textLabel?.text = nickName
            textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        } else if section == 1 {
            dotView.isHidden = true
            textLabel?.text = personalSetting[indexPath.row]
        } else if section == 2 {
            dotView.isHidden = true
            textLabel?.text = AppService[indexPath.row]
        } else if section == 3 {
            dotView.isHidden = true
            textLabel?.text = designBy[indexPath.row]
            imageView?.image = designByImage[indexPath.row]
            imageView?.contentMode = .scaleAspectFill
        }
    }
}

//let personalImage = [UIImage(resource: .person)?.withTintColor(.black, renderingMode: .alwaysOriginal)]
//let AppServiceImgae = [
//    UIImage(resource: .appBadge)?.withTintColor(.black, renderingMode: .alwaysOriginal),
//    UIImage(resource: .mail)?.withTintColor(.black, renderingMode: .alwaysOriginal),
//    UIImage(resource: .infoCircle)?.withTintColor(.black, renderingMode: .alwaysOriginal)]
//let designByImage = [
//    UIImage(assetName: .github)?.withTintColor(.black, renderingMode: .alwaysOriginal),
//    UIImage(assetName: .behance)?.withTintColor(.black, renderingMode: .alwaysOriginal)
//]

