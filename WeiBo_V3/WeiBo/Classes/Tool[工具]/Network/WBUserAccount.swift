//
//  WBUserAccount.swift
//  WeiBo
//
//  Created by Qinting on 16/9/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

class WBUserAccount: NSObject {

    ///访问令牌
    var access_token :String?
    ///用户代码
    var uid : String?
    /// access_token 的生命周期，单位是秒数 开发者5年 使用者 3天
    var expires_in : TimeInterval = 0
    
    override var description: String {
          return yy_modelDescription()
    }
    
}
