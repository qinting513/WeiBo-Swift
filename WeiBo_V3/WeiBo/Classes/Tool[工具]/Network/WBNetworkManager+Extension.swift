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
    
    //返回微博的未读数量
    func unreadCount(completion:(count : Int) -> () ) {
        guard let uid = userAccount.uid  else {
            return
        }
        let urlString  = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid" : uid]
        tokenRequest(urlString: urlString, parameters: params) { (json, isSuccess) in
            print("未读json:\(json) ")
            let dict = json as? [String : AnyObject]
            let count = dict?["status"]  as? Int
            // ?? 2个问号表示如果有值则用值，如果没有则是0
            completion(count: count ?? 0 )
        }
        
    }
    
}

//MARK: - OAuth相关的方法
extension WBNetworkManager {
    //获取accessToken的方法
//    提问 网络请求 异步应该返回什么   --- > 需要什么就返回什么
    func loadAccessToken(code:String, completion : (isSuccess:Bool) -> ()) {
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,
                             "client_secret":WBAppSecret,
                             "grant_type":"authorization_code",
                              "code":code,
                              "redirect_uri":WBRedirectURI
                                    ]
        request(method: .POST, urlString: urlStr, parameters: params) { (json, isSuccess) in
            print("accessToken :\(json)")
            // [:] 空字典
            self.userAccount.yy_modelSet(with: json as? [String:AnyObject]  ?? [:] )
            self.userAccount.saveAccount()
            completion(isSuccess: isSuccess)
        }

    }
}
