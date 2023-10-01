//
//  TabBarController.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/10/01.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //추가할 VC
    let main = MainViewController()
    let myPage = MyPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        viewSet()
    }
    
    //탭바 설정
    func viewSet(){
        addViewControllers()
        self.tabBar.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.tabBar.tintColor = .mainBlue
        self.tabBar.unselectedItemTintColor = .bgGrey
        self.tabBar.backgroundColor = .white
    }
    
    //탭바에 VC추가
    func addViewControllers() {
        let mainTab = createViewController(title: "내 질문", imageName: "headphones", viewController: main)
        let myPageTab = createViewController(title: "내 정보", imageName: "person.fill", viewController: myPage)
        self.viewControllers = [mainTab, myPageTab]
    }
    
    //VC에 네비게이션 컨트롤러 연결 및 각 탭에 대한 이미지 설정
    func createViewController(title: String, imageName: String, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        let image = UIImage(systemName:imageName)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title

        return nav
    }
}
