//
//  YStatusResult.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation

class YStatusResult: NSObject {
    
    /// 用户的微博数组（YStatus）
    var statuses: NSArray = NSArray()
    /// 用户最近的微博总数
    var total_number: Int?
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["statuses":YStatus.self]
    }
}