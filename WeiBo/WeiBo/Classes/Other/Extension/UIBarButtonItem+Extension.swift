//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title:String, fontSize:CGFloat = 16.0,normalColor:UIColor, highlightedColor:UIColor,  target:AnyObject?,  action:Selector ) {
        let button : UIButton = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        button.setTitleColor(normalColor, forState: .Normal)
        button.setTitleColor(highlightedColor, forState: .Highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
//        实例化
        self.init(customView: button)
    }
    
    convenience init(imageName:String, highlightImageName:String,target:AnyObject?,  action:Selector){
        self.init(imageName:imageName, highlightImageName:highlightImageName,bgImageName:nil, highlightedBgImageName:nil,  target:target,  action:action)
    }
    
    convenience init( imageName:String, highlightImageName:String, bgImageName:String?,  highlightedBgImageName:String?,  target:AnyObject?,  action:Selector){
        let button : UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named:imageName ), forState: .Normal)
        button.setImage(UIImage(named:highlightImageName ), forState: .Highlighted)
        
//        使用if let  后必定是有值的
        if let bgImageName = bgImageName, highlightBgImageName = highlightedBgImageName {
            button.setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
            button.setBackgroundImage(UIImage(named:highlightBgImageName), forState: .Normal)
        }
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        //        实例化
        self.init(customView: button)
    }
    
}
