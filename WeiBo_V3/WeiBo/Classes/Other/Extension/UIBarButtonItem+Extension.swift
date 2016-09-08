//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

  //便利初始化器最终一定以调用一个指定初始化器结束
extension UIBarButtonItem {
    
    convenience init(title:String, fontSize:CGFloat = 16.0,normalColor:UIColor, highlightedColor:UIColor,  target:AnyObject?,  action:Selector ) {
        let button : UIButton = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.setTitleColor(normalColor, for: UIControlState())
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
//        实例化
        self.init(customView: button)
    }
    
    
    convenience init(imageName:String, highlightImageName:String,target:AnyObject?,  action:Selector){
        self.init(imageName:imageName, highlightImageName:highlightImageName,bgImageName:nil, highlightedBgImageName:nil,  target:target,  action:action)
    }
    
    convenience init( imageName:String, highlightImageName:String, bgImageName:String?,  highlightedBgImageName:String?,  target:AnyObject?,  action:Selector){
        let button : UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named:imageName ), for: UIControlState())
        button.setImage(UIImage(named:highlightImageName ), for: .highlighted)
        
//        使用if let  后必定是有值的
        if let bgImageName = bgImageName, highlightBgImageName = highlightedBgImageName {
            button.setBackgroundImage(UIImage(named: bgImageName), for: UIControlState())
            button.setBackgroundImage(UIImage(named:highlightBgImageName), for: UIControlState())
        }
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        //        实例化
        self.init(customView: button)
    }
    
}
