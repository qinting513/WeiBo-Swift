//
//  WBStatus.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import YYModel

class WBStatus: NSObject {

    var id : Int64 = 0
    // 微博内容
    
    var text : String?
    
    override  var description: String {
    return yy_modelDescription()
    }
}
