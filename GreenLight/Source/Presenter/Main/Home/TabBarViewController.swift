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
    private let random = RandomViewController()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        setTabBar()
        addViewControllers()
    }
    
    func setTabBar() {
        self.tabBar.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.tabBar.tintColor = .mainBlue
        self.tabBar.unselectedItemTintColor = .tabBarGrey
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = true
        self.delegate = self
    }
    
    func addViewControllers() {
        let homeTab = createViewController(title: "내 질문", imageName: "headphones", viewController: home)
        let randomTab = createViewController(title: "랜덤 면접", imageName: "dice", viewController: myPage)
        let myPageTab = createViewController(title: "내 정보", imageName: "person.fill", viewController: myPage)
        self.viewControllers = [homeTab, randomTab, myPageTab]
    }
    
    func createViewController(title: String, imageName: String, viewController: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: viewController)
        let image = UIImage(systemName:imageName)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        return nav
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.feedbackGenerator.prepare()
        self.feedbackGenerator.impactOccurred()
    }
}
