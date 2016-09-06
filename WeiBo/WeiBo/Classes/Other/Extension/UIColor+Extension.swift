//
//  UIColor+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

extension UIColor {
         class  func randomColor() -> UIColor {
//             red  = CGFloat0 / CGFloat 1  2个CGFloat数值比较
            let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            return UIColor.init(red:red, green:green, blue:blue , alpha: 1)
    }

}
