//
//  WBNetworkManager+Extension.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation


//MARK: - 封装新浪微博的网络请求方法

extension WBNetworkManager {

    /// 加载微博数据字典数组
    /// completion： 完成回调list
    func statusList (completion:(list : [ [String:AnyObject] ]?, isSuccess : Bool)-> ( ) ){
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token" : "2.00_26_KC0OvKcC26c31896fboBoooD"]
        request(method: .GET, urlString: urlString, parameters: params) { (json, isSuccess) in
//            as? 失败 则 result ＝ nil  否则有值
            let result = json?["status"] as? [ [String:AnyObject] ]
            completion(list: result, isSuccess: isSuccess)
        }
    }
    
}
