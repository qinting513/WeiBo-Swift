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
//       关键点：把系统导航栏隐藏
        navigationBar.isHidden = true;
    }
    
    /** 重写push方法 */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /** 如果有子VC 则隐藏底部的  根控制器不需要处理*/
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        
        //         取出自定义的 naviItem
        if let vc = viewController as? WBBaseViewController {
            let backBtn = UIButton(type: .custom)
            backBtn.setImage(UIImage(named: "navigationbar_back_withtext"), for: UIControlState())
            backBtn.setImage(UIImage(named: "navigationbar_back_withtext_highlighted"), for: .highlighted)
            backBtn.contentHorizontalAlignment = .left
            
            var title = "返回"
//           判断控制器的级数，只有一个子控制器的时候，显示栈底控制器的标题
            if  childViewControllers.count == 1 {
                  title = childViewControllers.first?.title ??  "返回"
            }
            backBtn.setTitle(title, for: UIControlState())
            backBtn.setTitleColor(UIColor.black(), for: UIControlState(rawValue:0))
            backBtn.setTitleColor(UIColor.orange(), for: .highlighted)
            backBtn.bounds = CGRect(x: 0, y: 0, width: 70, height: 30)
            backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
            vc.naviItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            backBtn.addTarget(self, action:#selector(WBMainNavigationController.back), for: .touchUpInside)
        }
          
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func back() {
        self.popViewController(animated: true)
    }
    
    //    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
    //        
    //    }
}

