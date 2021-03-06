//
//  WBMainTabBarController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

/**  note：
 容错点： */
import SVProgressHUD
import UIKit

class WBMainTabBarController: UITabBarController {
    
    //定时器 检查新微博
    private var timer : Timer?
    //    私有控件
    private lazy var composeButton : UIButton = UIButton.qt_imageButton("tabbar_compose_icon_add", highlightedImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        设置子控制器
        setupChildControllers()
//        中间的加号按钮
        setupComposeButton()
//        设置定时器，监听未读消息
        setupTimer()
        
        delegate = self
        NotificationCenter.default().addObserver(self, selector: #selector(login), name: WBUserShouldLoginNotification, object: nil)
    }
    
    override func  supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    //    MARK: 撰写按钮 事件
    @objc private func login(n : NSNotification){
        print("用户登录的通知:\(n)")
        WBNetworkManager.shared.userLoging = false
        var when = DispatchTime.now()
        //n.object 如果是token 过期的话 object传一个 bad token
        if n.object != nil {
            //设置遮罩样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，请重新登录")
            when = DispatchTime.now() + 2
        }
        DispatchQueue.main.after(when: when ) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let vc = UINavigationController.init(rootViewController:  WBOAuthViewController())
            self.present(vc, animated: true, completion: nil)
        }

        
    }

    /** private 保证方法私有，只能当前控制器可以访问，
     @objc 允许这个函数在运行时 通过OC的消息机制被调用
     */
        //    FIXME:没有实现
    @objc  private func composeButtonStatus( ) {
        print("撰写weibo")
        
        //    test code
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    deinit{
        timer?.invalidate()
        NotificationCenter.default().removeObserver(self)
    }
    
}

//遵守协议的写法
extension WBMainTabBarController : UITabBarControllerDelegate{

  /** 即将选择TabBarItem */
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        
//        取出viewController在子控制器数组中的位置
        let idx = (childViewControllers as NSArray).index(of: viewController)
        //        判断当前索引是首页 同时idx也是首页，重复点击首页按钮
        if selectedIndex == 0 && selectedIndex == idx {
            //        让表格滚动到顶部
            let nav = childViewControllers[0] as! WBMainNavigationController
            let vc = nav.viewControllers[0] as! WBHomeViewController
            vc.tableView?.setContentOffset(CGPoint(x: 0 , y:-64), animated: true)
            //            加载数据 bug：得让tableView滚动到顶部之后 才加载数据，所以需延时1秒
            DispatchQueue.main.after(when: DispatchTime.now() + 1, execute: {
                  vc.loadData()
            })
        }
        // 判断目标控制器是否上ViewController
        return  !viewController.isMember(of: UIViewController.self)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
    
        
    }
}

//通过分类 进行优化
extension WBMainTabBarController {
    
    //    添加按钮
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        //        计算按钮宽度
        let count = CGFloat(childViewControllers.count)
        //  MARK:  -将向内缩进的宽度减少，能够让按钮的宽度变大，盖住容错点，防止穿帮 ！
//        let w = tabBar.frame.size.width / count - 1
        let w = tabBar.frame.size.width / count
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

//定时器 检查未读消息
extension WBMainTabBarController {
    
    private func setupTimer(){
//        没有登陆 就不创建定时器了
        if  !WBNetworkManager.shared.userLogon {
                return
        }
           timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
//    设置首页
    func updateTimer(){
//        if    !WBNetworkManager.shared.userLoging {
//                return
//        }
       WBNetworkManager.shared.unreadCount { (count) in
//        用中括号直接强制解包了，用first还是可选项
           self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
//        从iOS8之后要申请用户授权之后才可以显示
           UIApplication.shared().applicationIconBadgeNumber = count
        }
    }

}
