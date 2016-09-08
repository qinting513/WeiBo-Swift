//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation

//上拉刷新 最大尝试次数
private let maxPullupTryTime = 3

class WBStatusListViewModel {
    
    // 微博模型数组 懒加载
    lazy var statusList = [WBStatus]()
    
    ///上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    ///    加载微博列表
    ///   completion 网络请求是否成功
    func loadStatus(pullup:Bool, completion : (isSuccess : Bool,shouldRefresh:Bool) -> () )  {
//        判断是否是上拉刷新，同时检查错误次数
        if pullup  && pullupErrorTimes > maxPullupTryTime {
               completion(isSuccess: true, shouldRefresh: false)
            return
        }
        
//        下拉刷新  取出微博的第一条数据的id
        let since_id = statusList.first?.id ?? 0
//        上拉刷新，取出最后一条数据的id
        let max_id = !pullup ? 0 : (statusList.last?.id  ??  0 )

        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            //                list 可能为空 用空数组 ?? []  --> 安全感
            //               1. yymodel 进行解析数据模型  字典转 模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                  completion(isSuccess: isSuccess,shouldRefresh: false)
                return
            }
            
            if pullup {
            self.statusList  +=  array
            }else{
                // 2. 拼接数据
                self.statusList  =  array + self.statusList
            }
            
            //3.判断上拉刷新的数据量 
            if pullup && array.count == 0 {
                    self.pullupErrorTimes += 1
                completion(isSuccess: isSuccess, shouldRefresh: false)
            }else{
                // 3. 完成回调
                completion(isSuccess: isSuccess,shouldRefresh: true)
            }
            
        }
    }
    
}
