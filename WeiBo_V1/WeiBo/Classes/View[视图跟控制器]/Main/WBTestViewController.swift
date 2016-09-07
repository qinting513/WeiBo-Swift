//
//  WBTestViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBTestViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
  
    }
    
    @objc private func nextVC () {
    navigationController?.pushViewController(WBTestViewController(), animated: true)
        
    }

    

}
extension WBTestViewController {
    override func setupUI() {
        //        重写前要先重写父类的方法
        super.setupUI()
        naviItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", fontSize: 15, normalColor: UIColor.darkGray(), highlightedColor: UIColor.orange(), target: self, action: #selector(WBTestViewController.nextVC))
       }
}
