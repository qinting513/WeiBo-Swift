//
//  WBNetworkManager.swift
//  WeiBo
//
//  Created by Qinting on 16/9/7.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {

    /// 静态区/常量区/闭包  在第一次访问时执行执行闭包，并且将结果保存在shared常量中
    static let shared = WBNetworkManager()

    //访问令牌，所有的网络请求都基于此令牌（登录除外）
    var accessToken  : String?   // = "2.00_26_KCMXbl5E7d1ad885e6jc2agB"
//    var accessToken  : String? = "2.00_26_KC0OvKcC26c31896fboBoooD"
    
//    用户微博 id 
    var uid : String? = "5365823342"
    
//    用户登录标记
    var userLogon : Bool {
            return accessToken != nil
    }
    
    ///专门负责拼接token 的网络请求方法
    func tokenRequest( method:WBHTTPMethod = .GET, urlString:String,  parameters : [String:AnyObject]?,
                       completion :  (json:AnyObject?, isSuccess : Bool) ->()  ){
//    0.判断token是否为nil  为ni 直接返回
       guard let token = accessToken else{
                //FIXME: 发送通知 谁接收 谁处理，提醒用户登录
            print("没有token 需要登录")
            completion(json: nil, isSuccess: false)
            return
        }
//        1.如果为nil，则 创建一个
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
//        2.设置参数字典 此处肯定有值
        parameters!["access_token"] =  token
        
        request(method: method, urlString: urlString, parameters: parameters, completion: completion)
    }
    
    func request(method:WBHTTPMethod = .GET, urlString:String,  parameters : [String:AnyObject]?,
                 completion :  (json:AnyObject?, isSuccess : Bool) ->() ) {
    
//        成功回调
        let success = { (task:URLSessionDataTask, json: AnyObject?) -> () in
            completion(json: json, isSuccess: true)
        }
        
//        失败回调
        let failure = { (task:URLSessionDataTask?, error:NSError) -> () in
            //处理 用户token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
            print("用户token 过期")
                //FIXME: 发送通知 谁接收 谁处理，提醒用户登录
            }
            
            print("网络请求错误：\(error)")
            completion(json: nil, isSuccess: false)
        }
        
        if  method == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
