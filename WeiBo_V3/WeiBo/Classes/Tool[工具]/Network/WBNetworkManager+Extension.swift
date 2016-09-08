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
    
//    基础方法1:
    //        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
    //        let params = ["access_token" : "2.00_26_KC0OvKcC26c31896fboBoooD"]
    ////        WBNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
    ////            print(json)
    ////        }) { (_, error) in
    ////            print(error)
    ////        }
//    封装 基础方法2:
    //        WBNetworkManager.shared.request(method: .GET, urlString: urlString, parameters: params) { (json, isSuccess) in
    //            if isSuccess && json != nil {
    //            print(json)
    //            }
    //        }
//    封装 方法3 :
    /// 加载微博数据字典数组
    /// completion： 完成回调list
//    func statusList (completion:(list : [ [String:AnyObject] ]?, isSuccess : Bool)-> ( ) ){
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token" : "2.00_26_KC0OvKcC26c31896fboBoooD"]
//        request(method: .GET, urlString: urlString, parameters: params) { (json, isSuccess) in
////            as? 失败 则 result ＝ nil  否则有值
//            let result = json?["statuses"] as? [ [String:AnyObject] ]
//            completion(list: result, isSuccess: isSuccess)
//        }
//    }
    
    //    封装 方法4 : 将token封装起来
    func statusList  (since_id:Int64 = 0 , max_id:Int64 = 0,  completion:(list : [ [String:AnyObject] ]?, isSuccess : Bool)-> ( ) ){
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id":"\(since_id)", "max_id":"\(max_id > 0 ? max_id - 1 : 0 )"]
          tokenRequest(urlString: urlString, parameters: params) { (json, isSuccess) in
//            注意要回调
            print("json====: \(json)")
//            取出statuses 对应的数组，数组里的元素是字典类型的
           let result = json?["statuses"] as? [ [String:AnyObject] ]
            completion(list: result, isSuccess: isSuccess)
        }
    }
    
}
