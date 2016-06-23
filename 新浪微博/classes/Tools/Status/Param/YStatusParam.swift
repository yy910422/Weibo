//
//  YStatusParam.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation

class YStatusParam: YBaseParam {
    /// since_id 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    var since_id: String?
    /// max_id 	int64 	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    var max_id: String?
}