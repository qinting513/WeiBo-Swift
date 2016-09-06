//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /**  private 使私有化，@objc 使运行时可以来调用此方法 */
   @objc private func showFriends( ) {
          navigationController?.pushViewController(WBTestViewController(), animated: true)
    }


}

extension WBHomeViewController {
    override func setupUI() {
        //        重写前要先重写父类的方法
        super.setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_friendattention"), style: .Plain, target: self, action: #selector(WBHomeViewController.showFriends))
    }
    
}
