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
    
    override func  supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    //    MARK: 撰写按钮 事件
    //    FIXME:没有实现
    /** private 保证方法私有，只能当前控制器可以访问，
     @objc 允许这个函数在运行时 通过OC的消息机制被调用
     */
    @objc  private func composeButtonStatus( ) {
        print("撰写weibo")
        
        //    test code
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    //    私有控件
    private lazy var composeButton : UIButton = UIButton.qt_imageButton("tabbar_compose_icon_add", highlightedImageName: "tabbar_compose_button")
    
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
        composeButton.addTarget(self, action: #selector(WBMainTabBarController.composeButtonStatus), for: .touchUpInside)
    }
    
    //设置所有子控制器
    private func setupChildControllers() {
//        获取沙盒json
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        var  data = NSData(contentsOfFile: jsonPath)
        if data  == nil {
//        如果沙盒里的为空 则从bundle里获取
            let   path = Bundle.main().pathForResource("main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        guard let array = try?  JSONSerialization.jsonObject(with: data!  as Data, options: [])  as?  [[String:AnyObject]]
        else {
            return
        }
        
//                let array : [ [String:AnyObject] ] = [
//                    ["clsName":"WBHomeViewController",    "title":"首页",   "imageName": "home",
//                     "visitorInfo" : ["imageName":"", "message": "关注一些人，回这里看看有什么惊喜"]
//                    ],
//                    ["clsName":"WBMessageViewController",  "title":"消息",    "imageName": "message_center",
//                     "visitorInfo" : ["imageName":"visitordiscover_image_message", "message": "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"]
//                    ],
//                    ["clsName" : "UIViewController"],
//                    ["clsName":"WBDiscoverViewController",  "title":"发现",   "imageName": "discover",
//                     "visitorInfo" : ["imageName":"visitordiscover_signup_logo", "message": "登录后，最新、最热微博尽在掌握，不会再与潮流擦肩而过"]
//                    ],
//                    ["clsName":"WBProfileViewController",     "title":"我",        "imageName": "profile",
//                     "visitorInfo" : ["imageName":"visitordiscover_image_profile", "message": "登录后，你的相册、微博、个人资料都会显示在这里展示给别人"]
//                    ],
//                    ]
//        将数据输出为json格式
//        let data = try!  JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data as NSData).write(toFile: "/Users/qinting/Desktop/main.json",atomically: true)
        
        var vcs = [UIViewController]()
        for dict in array! {
            vcs.append( controller(dict: dict) )
        }
        viewControllers = vcs
    }
    
    
    /** 使用一个字典 创建一个子控制器
     * 信息字典  [clsName, title, imageName]
     */
    private func controller( dict: [String : AnyObject] ) -> UIViewController {
        //        guard let 进行判断
        guard let clsName = dict["clsName"] as? String,
            title = dict["title"] as? String,
            imageName = dict["imageName"] as? String,
            visitorDict = dict["visitorInfo"] as? [String : String],
            cls = NSClassFromString(Bundle.main().namespace + "." + clsName) as? WBBaseViewController.Type  else{
                return UIViewController()
        }
        //         create vc
        let  vc = cls.init()
        vc.title = title
        vc.visitorInfoDictionary = visitorDict
        vc.tabBarItem.image = UIImage(named: "tabbar_" +  imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" +  imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //      设置高亮时的字体
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange()], for: .highlighted)
        
        //        设置正常状态下的字体大小 系统默认是12，swift3.0 没有 Normal  设置 UIControlState(rawValue: 0) 就是normal状态
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0) )
        
        
        //        嵌套一个导航控制器
        let nav = WBMainNavigationController(rootViewController: vc)
        return nav
    }
}
