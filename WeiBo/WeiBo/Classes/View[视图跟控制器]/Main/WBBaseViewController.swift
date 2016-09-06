//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

//面试题 OC中支持多继承吗 如果不支持，如何替代  答案： 使用协议替代
//class WBBaseViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
//swift 中，利用‘extension’可以把函数按照功能分类管理，便于阅读跟维护
//注意：
//1. extension中不能有属性
//2.extension中不能重写父类方法，重写父类方法，是子类的职责，扩展是对类的扩展，使类的功能更强大

//主控制机器基类
class WBBaseViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
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
    
//    MARK: - 设置tableView
    private func setupTableView(){
    tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
//    MARK: - 设置导航条
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

extension WBBaseViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
//    基类只是准备方法，子类负责具体实现，子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        只是保证没有语法错误
        return UITableViewCell()
    }
}
