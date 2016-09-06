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
      
        navigationBar.hidden = true;
    }
    
    /** 重写push方法 */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        /** 如果有子VC 则隐藏底部的  根控制器不需要处理*/
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        
        //         取出自定义的 naviItem
        if let vc = viewController as? WBBaseViewController {
            let backBtn = UIButton(type: .Custom)
            backBtn.setImage(UIImage(named: "navigationbar_back_withtext"), forState: .Normal)
            backBtn.setImage(UIImage(named: "navigationbar_back_withtext_highlighted"), forState: .Highlighted)
            backBtn.contentHorizontalAlignment = .Left
            backBtn.setTitle( childViewControllers.first?.title, forState: .Normal)
            backBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            backBtn.setTitleColor(UIColor.orangeColor(), forState: .Highlighted)
            backBtn.bounds = CGRect(x: 0, y: 0, width: 70, height: 30)
            backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
            vc.naviItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            backBtn.addTarget(self, action:#selector(WBMainNavigationController.back), forControlEvents: .TouchUpInside)
        }
          
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func back() {
        self.popViewControllerAnimated(true)
    }
    
    //    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
    //        
    //    }
}

