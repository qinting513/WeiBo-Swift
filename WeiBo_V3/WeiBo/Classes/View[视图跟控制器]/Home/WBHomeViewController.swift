//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

private let cellID = "HomeCell"

class WBHomeViewController: WBBaseViewController {
//微博数据数组，懒加载
    private lazy var statusList = [String]()
    
    override func loadData() {

        WBNetworkManager.shared.statusList { (list, isSuccess) in
                      print(list)
        }
        
//        模拟 ‘延时’加载 dispatch_after
       DispatchQueue.main.after(when: DispatchTime.now() + 2) {
                for i in 0  ..< 15 {
//                    在闭包中要加上self，指定语境
                    if self.isPullup {
//                    如果是上拉刷新 将数据追加到底部
                        self.statusList.append("上拉刷新 --- \(i)")
                    }else{
//                    下拉刷新
                        self.statusList.insert("\(i)", at: 0)
                    }
                }
        //                    恢复上拉刷新标记
        self.isPullup = false
        self.tableView?.reloadData()
        self.refreshControl?.endRefreshing()
//               print( self.statusList)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
    }

    /**  private 使私有化，@objc 使运行时可以来调用此方法 */
   @objc private func showFriends( ) {
          navigationController?.pushViewController(WBTestViewController(), animated: true)
    }
}

extension WBHomeViewController {
    override func setupTableView() {
    //        重写前要先重写父类的方法
        super.setupTableView()
        
        naviItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", highlightImageName: "navigationbar_friendattention_highlighted", target: self, action: #selector(WBHomeViewController.showFriends))
  
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

//MARK: - 重写 tableView DataSource 方法，不需要super
extension WBHomeViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
           cell.textLabel?.text = statusList[indexPath.row]
            return cell
    }
}
