//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 64))
    
//    自定义的导航项
    lazy var naviItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
    }
    
//    重写title  的 setter方法
    override var title: String? {
        didSet{
      naviItem.title = title
        }
    }

}

//设置界面
extension WBBaseViewController {

     func setupUI() {
//        添加一个导航栏
        view.backgroundColor = UIColor().randomColor()
        view.addSubview(navigationBar)
//        设置导航项
        navigationBar.items = [naviItem]
        navigationBar.barTintColor = UIColor(white: 0xF6F6F6, alpha: 1.0)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGrayColor()]
    }


}