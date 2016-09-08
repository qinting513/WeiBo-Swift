//
//  AppDelegate.swift
//  WeiBo
//
//  Created by Qinting on 16/9/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // #available 检测版本是 10.0 以上的
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization([.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        } else {
            //        取得用户授权显示通知（上方的提示音／声音／badgeNumber）
            let notifySetting = UIUserNotificationSettings(types: [.alert, .badge], categories: nil)
            application.registerUserNotificationSettings(notifySetting)
        }
        
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white()
        
        window?.rootViewController = WBMainTabBarController()
        
        window?.makeKeyAndVisible()
        
        loadAppInfo()

        return true
    }

}

//MARK: - 从服务器加载应用程序信息
extension AppDelegate{
    private func loadAppInfo(){
    DispatchQueue.main.async { 
        let  url = Bundle.main().pathForResource("main.json", ofType: nil)
        let data = NSData(contentsOfFile: url!)
        //写入磁盘
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        data?.write(toFile: jsonPath, atomically: true)
        print("应用程序加载完毕"+jsonPath)
        }
        
    }

}
