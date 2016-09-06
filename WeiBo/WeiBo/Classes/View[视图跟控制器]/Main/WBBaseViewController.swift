//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
    }


}

//设置界面
extension WBBaseViewController {

     func setupUI() {
           view.backgroundColor = UIColor.yellowColor()
        let color0:CGFloat =  CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        let color1:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        let color2:CGFloat =  CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        view.backgroundColor = UIColor(red: color0, green: color1, blue: color2, alpha: 1.0)
    }

}