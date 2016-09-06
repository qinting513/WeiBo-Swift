//
//  WBMainNavigationController.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBMainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        self.navigationBarHidden = true
        
    }
}
