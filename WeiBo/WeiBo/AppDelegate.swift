//
//  AppDelegate.swift
//  WeiBo
//
//  Created by Qinting on 16/9/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = WBMainTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }

 
}

