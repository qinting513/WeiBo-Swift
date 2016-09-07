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

//    ViewModel 实例
  private  lazy  var listViewModel = WBStatusListViewModel()
    
    override func loadData() {
        
        listViewModel.loadStatus { (isSuccess) in
            //                    恢复上拉刷新标记
            self.isPullup = false
            self.tableView?.reloadData()
            self.refreshControl?.endRefreshing()
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
         return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        print("list: \( listViewModel.statusList[indexPath.row].text )")
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
            return cell
    }
}
