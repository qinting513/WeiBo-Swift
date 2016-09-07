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
    
    
    func request(method:WBHTTPMethod = .GET, urlString:String,  parameters : [String:AnyObject],
                 completion :  (json:AnyObject?, isSuccess : Bool) ->() ) {
    
//        成功回调
        let success = { (task:URLSessionDataTask, json: AnyObject?) -> () in
            completion(json: json, isSuccess: true)
        }
        
//        失败回调
        let failure = { (task:URLSessionDataTask?, error:NSError) -> () in
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
