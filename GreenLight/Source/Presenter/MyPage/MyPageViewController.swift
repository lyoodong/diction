//
//  MyPageViewController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

protocol MyPageViewModelProtocol {
    var myPageViewModel: MyPageViewModel { get }
    
}

class MyPageViewController: BaseViewController, MyPageViewModelProtocol {
    
    var myPageViewModel: MyPageViewModel
    let myPageView = MyPageView()
    
    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myPageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myPageView.myPageTableView.reloadData()
    }
    
    override func configure() {
        setTableView()
        setNavigationItem()
    }
}

extension MyPageViewController {
    func setNavigationItem() {
        self.navigationItem.backButtonTitle = ""
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        myPageView.myPageTableView.dataSource = self
        myPageView.myPageTableView.delegate = self
        myPageView.myPageTableView.register(MyPageViewCell.self, forCellReuseIdentifier: MyPageViewCell.IDF)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        lazy var label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        
        lazy var headerView = UIView().then {
            $0.backgroundColor = .white
            $0.addSubview(label)
        }
        
        let width = UIScreen.main.bounds.width
        
        label.snp.makeConstraints {
            $0.top.equalTo(headerView).offset(Constant.spacing)
            $0.leading.equalTo(headerView).offset(Constant.spacing * 2)
        }
        
        if section == 0 {
            label.text = ""
        } else if section == 1 {
            label.text = "APP 설정"
        } else if section == 2 {
            label.text = "서비스"
        } else {
            label.text = "MadeBY"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:MyPageViewCell.IDF , for: indexPath) as? MyPageViewCell else {
            return UITableViewCell()
        }
        cell.setCell(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        
        func openUrl(url: URL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        
        if section == 1 {
            let vc = EditNameViewController(editNameViewModel: EditNameViewModel())
            if let sheet = vc.sheetPresentationController {
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = true
                sheet.detents = [.custom(resolver: { _ in
                    return UIScreen.main.bounds.height * 0.3
                })]
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if section == 2 {
            
            if row == 0 {
                if let url = URL(string: "https://forms.gle/ktW1t3hjPxHJs9kn9") {
                    openUrl(url: url)
                }
            } else if row == 1 {
                let vc = PolicyViewController()
                present(vc, animated: true)
            }
        }
        
        if section == 3 {
            if row == 0 {
                if let url = URL(string: "https://github.com/lyoodong") {
                    openUrl(url: url)
                }
            } else if row == 1 {
                if let url = URL(string: "https://www.behance.net/hyewoncho81") {
                    openUrl(url: url)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 44
        }
    }
}
