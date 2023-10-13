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
    private let random = RandomViewController()
    private let myPage = MyPageViewController()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        addViewControllers()
    }
}

//MARK: - tabBar 설정 및 뷰 추가
extension TabBarViewController {
    
    private func setTabBar() {
        self.tabBar.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.tabBar.tintColor = .mainBlue
        self.tabBar.unselectedItemTintColor = .tabBarGrey
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = true
        self.delegate = self
    }
    
    private func addViewControllers() {
        let homeTab = createViewController(title: "내 질문", imageName: "headphones", viewController: home)
        let randomTab = createViewController(title: "랜덤 면접", imageName: "dice", viewController: random)
        let myPageTab = createViewController(title: "내 정보", imageName: "person.fill", viewController: myPage)
        self.viewControllers = [homeTab, randomTab, myPageTab]
    }
    
    private func createViewController(title: String, imageName: String, viewController: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: viewController)
        let image = UIImage(systemName:imageName)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        return nav
    }

}

//MARK: - feedbackGenerator 생성
extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.feedbackGenerator.prepare()
        self.feedbackGenerator.impactOccurred()
    }
}
