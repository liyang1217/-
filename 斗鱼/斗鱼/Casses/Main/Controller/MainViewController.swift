//
//  MainViewController.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }
        fileprivate func addChildVC(storyName: String){
    
            //1. 通过storyBoard获取控制器
            let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
    
            //2. 将childVC作为子控制器
            addChildViewController(childVC)
        }
}











