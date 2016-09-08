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
//    添加刷新控件
    var refreshControl : UIRefreshControl?
//    上拉刷新标记
    var isPullup = false
////    用户登录标记
//    var userLogon = true
//    设置访客视图信息的字典
    var visitorInfoDictionary : [String:String]?
    
// MARK:-   隐藏系统的后，自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main().bounds.size.width, height: 64))
    
// MARK: -   自定义的导航项
    lazy var naviItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
//        如果我想每次都加载，那就放在viewWillAppear方法里,用户登录了才刷新数据
        WBNetworkManager.shared.userLogon ? loadData() : ()
    }
    
//MARK: -    重写title  的 setter方法
    override var title: String? {
        didSet{
              naviItem.title = title
        }
    }
    
//    加载数据  具体的实现由子类负责
    func  loadData() {
//        如果不实现任何方法，则默认关闭
     refreshControl?.endRefreshing()
    }

}

//MARK:- 登录注册
extension WBBaseViewController{
    
    
 @objc  private  func registerBtnClick(){
    
    }
    
    //通知登录
 @objc private  func loginBtnClick()  {
    NotificationCenter.default().post(name: NSNotification.Name(rawValue:WBUserShouldLoginNotification) , object: nil)
    }
    
}

//设置界面
extension WBBaseViewController {

   private  func setupUI() {
        view.backgroundColor = UIColor.randomColor()
        setupNavi()
        WBNetworkManager.shared.userLogon ?  setupTableView() : setupVisitView()
    }
    
//    MARK: - 设置tableView
     func setupTableView(){
    tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.dataSource = self
        tableView?.delegate = self
        
//        取消自动缩进 如果隐藏了导航栏会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
//        设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ??  49 ,
                                                right: 0)
        
//        设置刷新控件
        refreshControl = UIRefreshControl()
        tableView?.addSubview(refreshControl!)
//        添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
//    MARK: - 设置访客视图
    private func setupVisitView(){

       let visitorView = WBVisitorView(frame: view.bounds)
        visitorView.backgroundColor = UIColor.white()
        view.insertSubview(visitorView, belowSubview: navigationBar)
        //        1.设置导航视图信息
        visitorView.visitorInfo = visitorInfoDictionary
        //2.添加监听方法
        visitorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        visitorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        //3.设置导航条按钮
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        naviItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
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
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
//    基类只是准备方法，子类负责具体实现，子类的数据源方法不需要super
  @objc(tableView:cellForRowAtIndexPath:)  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        只是保证没有语法错误
        return UITableViewCell()
    }
    
    /// 在显示最后一行的时候做上拉刷新
    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        判断是最后分区 最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
              return
        }

        let count = tableView.numberOfRows(inSection: section)
        //        判断最后一行,同时没有上拉刷新
        if row == (count - 1) && !isPullup {
//        print("上拉刷新")
            self.isPullup = true
            self.loadData()
        }
        
    }
    
    
}
