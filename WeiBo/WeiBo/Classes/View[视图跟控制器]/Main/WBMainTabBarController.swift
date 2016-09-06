//
//  WBMainTabBarController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

/**  note：
 容错点： */

import UIKit

class WBMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
    }
    
//    MARK: 撰写按钮 事件
//    FIXME:没有实现
    /** private 保证方法私有，只能当前控制器可以访问，
     @objc 允许这个函数在运行时 通过OC的消息机制被调用
     */
 @objc  private func composeButtonStatus( ) {
    print("撰写weibo")
    }

//    私有控件
    private lazy var composeButton : UIButton = UIButton.qt_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
}

//通过分类 进行优化
extension WBMainTabBarController {
    
//    添加按钮
    private func setupComposeButton() {
            tabBar.addSubview(composeButton)
        
//        计算按钮宽度
        let count = CGFloat(childViewControllers.count)
//  MARK:  -将向内缩进的宽度减少，能够让按钮的宽度变大，盖住容错点，防止穿帮 ！
        let w = tabBar.frame.size.width / count - 1
//        CGRectInset 正数是向内缩进， 负数是向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
//        print("撰写按钮宽度\(composeButton.bounds.size.width)") 
//        按钮的监听方法
        composeButton.addTarget(self, action: #selector(WBMainTabBarController.composeButtonStatus), forControlEvents: .TouchUpInside)
    }
    
//设置所有子控制器
    private func setupChildControllers() {
    let array = [
        ["clsName":"WBHomeViewController",      "title":"首页",   "imageName": "home"],
        ["clsName":"WBMessageViewController",  "title":"消息",    "imageName": "message_center"],
        ["clsName" : "UIViewController"],
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
        
//      设置高亮时的字体
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Highlighted)
        
//        设置正常状态下的字体大小 系统默认是12，swift3.0 没有 Normal  设置 UIControlState(rawValue: 0) 就是normal状态
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(14)], forState: UIControlState(rawValue: 0) )
        
        
//        嵌套一个导航控制器
         let nav = WBMainNavigationController(rootViewController: vc)
        return nav
    }
}