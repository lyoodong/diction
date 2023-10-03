//
//  TabBarController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit
import Then
import SnapKit

final class TabBarViewController: UITabBarController {
    
    private let home = HomeViewController()
    private let myPage = MyPageViewController()
    
    private let randomTap = UIButton().then {
        $0.setTitle("랜덤", for: .normal)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 28
        $0.addTarget(self, action: #selector(randomTapAddTarget), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
    }
    
    func viewSet(){
        setTabBar()
        addViewControllers()
        randomTapLayout()
    }
    
    func setTabBar() {
        self.tabBar.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.tabBar.tintColor = .mainBlue
        self.tabBar.unselectedItemTintColor = .tabBarGrey
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = true
    }
    
    func addViewControllers() {
        let homeTab = createViewController(title: "내 질문", imageName: "headphones", viewController: home)
        let myPageTab = createViewController(title: "내 정보", imageName: "person.fill", viewController: myPage)
        self.viewControllers = [homeTab, myPageTab]
    }
        
    func createViewController(title: String, imageName: String, viewController: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: viewController)
        let image = UIImage(systemName:imageName)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        return nav
    }
    
    func randomTapLayout() {
        view.addSubview(randomTap)
        
        randomTap.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(tabBar.snp.top).inset(15)
        }
    }
    
    @objc
    func randomTapAddTarget() {
        let vc = RandomViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}