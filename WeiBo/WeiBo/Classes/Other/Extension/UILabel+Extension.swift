//
//  UILabel+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/7.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init?(withText:String, fontSize:CGFloat, color:UIColor) {
        self.init()
        self.text = withText
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = color
        self.sizeToFit()
        self.numberOfLines = 0
    }

    

}
