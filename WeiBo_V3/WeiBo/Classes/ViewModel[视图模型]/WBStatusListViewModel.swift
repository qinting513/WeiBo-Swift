//
//  WBStatusListViewModel.swift
//  WeiBo
//
//  Created by Qinting on 16/9/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import Foundation

class WBStatusListViewModel {
    
    // 微博模型数组 懒加载
    lazy var statusList = [WBStatus]()
    
    ///    加载微博列表
    ///   completion 网络请求是否成功
    func loadStatus( completion : (isSuccess : Bool) -> () )  {
            WBNetworkManager.shared.statusList { (list, isSuccess) in
//                list 可能为空 用空数组 ?? []  --> 安全感
//               1. yymodel 进行解析数据模型  字典转 模型
                guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                             completion(isSuccess: isSuccess)
                    return
                }
                // 2. 拼接数据
                self.statusList += array
                // 3. 完成回调
                completion(isSuccess: isSuccess)
            }
     }
    
}
