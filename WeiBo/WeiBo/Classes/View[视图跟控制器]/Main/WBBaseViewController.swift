//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    //    如果用户没有登录 则不创建
    var tableView : UITableView?
    
// MARK:-   隐藏系统的后，自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main().bounds.size.width, height: 64))
    
// MARK: -   自定义的导航项
    lazy var naviItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
    }
    
//MARK: -    重写title  的 setter方法
    override var title: String? {
        didSet{
      naviItem.title = title
        }
    }

}

//设置界面
extension WBBaseViewController {

     func setupUI() {
        view.backgroundColor = UIColor.randomColor()
        setupNavi()
        setupTableView()
    }
    
    private func setupTableView(){
    
    }
    
    private func setupNavi(){
        //        添加一个导航栏
        view.addSubview(navigationBar)
        //        设置导航项
        navigationBar.items = [naviItem]
        //        设置naviBar的 背景 渲染颜色
        navigationBar.barTintColor = UIColor(white: 0xF6F6F6, alpha: 1.0)
        //        设置naviBar的 barButton 文字渲染颜色
        navigationBar.tintColor = UIColor.orange()
        //        设置naviBar的 标题字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray()]
    }

}
