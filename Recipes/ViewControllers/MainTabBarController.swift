//
//  MainTabBarController.swift
//  Recipes
//
//  Created by Инна Лаптева on 22.05.2020.
//  Copyright © 2020 Инна Лаптева. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let menuVC = MainViewController()
        let randomVC = RandomViewController()
        
        tabBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right.fill", withConfiguration: boldConfig)!
        
        viewControllers = [generationNavigationController(rootVC: menuVC, title: "Menu", image: conversationImage),
                           generationNavigationController(rootVC: randomVC, title: "Random", image: peopleImage)]
    }
    
    private func generationNavigationController(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
     
        let navigationVC = UINavigationController(rootViewController: rootVC)
        
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }

}
