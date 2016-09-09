//
//  WBUserAccount.swift
//  WeiBo
//
//  Created by Qinting on 16/9/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

let   filePath = NSHomeDirectory().appending("/Documents/userAccount.json")

class WBUserAccount: NSObject {

    ///访问令牌
    var access_token :String?
    ///用户代码
    var uid : String?
    
    /// access_token 的生命周期，单位是秒数 开发者5年 使用者 3天,会从第一次登录递减
    var expires_in : TimeInterval = 0 {
        didSet {  //expires_in 一有值 就设置
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }

    //处理过期日期
    var expiresDate : Date?
    override var description: String {
          return yy_modelDescription()
    }
    
    override init(){
         super.init()
        
        guard let data = NSData(contentsOfFile: filePath),
        dict = try? JSONSerialization.jsonObject(with: data as Data, options: [])  as?  [String:AnyObject]  else {
               return
        }
      // 2. 使用字典设置属性
        yy_modelSet(with: dict ?? [:])
        print("从沙盒获取的用户信息： \(dict)  ======== \(self)")
        
        /** 测试过期
         expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
         */
        
        // 3.处理账户过期  expiresDate 比当前的日期早，就过期了，比如expiresDate是7月1日，现在7月5日了，说明已过期
        if expiresDate?.compare(Date() ) != .orderedDescending {
        print("账号已过期")
            access_token = nil
            uid = nil;
          _  =  try?  FileManager.default().removeItem(atPath: filePath)
            return
        }
         print("账号正常\(self)")
    }
    
    /** 1.钥匙串访问 (SSkeychain)   2.偏好设置(Xcode 8.0 beta 无效) 3.数据库  4.归档  */
    func saveAccount() {
        //json保存
        //1.模型转字典
        var  dict = self.yy_modelToJSONObject() as? [String:AnyObject]  ?? [:]
        
        //2.删除expires_in 的值
        dict.removeValue(forKey: "expires_in")
        //3.字典序列化
        guard let data = try?  JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)  else{
                    return
        }
        (data as NSData).write(to: URL.init(fileURLWithPath: filePath), atomically: true)
    
    }
    
}
