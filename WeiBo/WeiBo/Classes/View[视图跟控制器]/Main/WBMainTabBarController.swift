//
//  WBMainTabBarController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
    }

}

//通过分类 进行优化
extension WBMainTabBarController {

//设置所有子控制器
    private func setupChildController() {
    let array = [
        ["clsName":"WBHomeViewController",      "title":"首页",   "imageName": "home"],
        ["clsName":"WBMessageViewController",  "title":"消息",    "imageName": "message_center"],
        ["clsName":"WBDiscoverViewController",  "title":"发现",   "imageName": "discover"],
        ["clsName":"WBProfileViewController",     "title":"我",        "imageName": "profile"],
        ]
        var vcs = [UIViewController]()
        for dict in array {
            vcs.append( controller(dict: dict) )
        }
        viewControllers = vcs
    }
    
    /** 使用一个字典 创建一个子控制器 
     * 信息字典  [clsName, title, imageName]
     */
    private func controller( dict dict: [String : String] ) -> UIViewController {
    guard let clsName = dict["clsName"],
        title = dict["title"],
        imageName = dict["imageName"],
        cls = NSClassFromString(NSBundle.mainBundle().namespace + "." + clsName) as? UIViewController.Type  else{
        return UIViewController()
        }
//         create vc
        let  vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" +  imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" +  imageName + "_selected")?.imageWithRenderingMode(.AlwaysOriginal)
         let nav = WBMainNavigationController(rootViewController: vc)
        return nav
    }
}