//
//  UIColor+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

extension UIColor {
    func randomColor() -> UIColor {
        let color0:CGFloat =  CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        let color1:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        let color2:CGFloat =  CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
        return UIColor(red: color0, green: color1, blue: color2, alpha: 1.0)
    }

}
