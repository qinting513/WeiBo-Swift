//
//  Bundle+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/6.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation

extension NSBundle{

    var namespace : String {
//        计算属性 类似于函数，没有参数 只有返回值 
//        前面是 ？ 的后面用可选解包 
//        ？？ 若没有值 则用空字符串 若有值 则用该值 
    return infoDictionary?["CFBundleName"]  as?  String ?? ""
    }
}