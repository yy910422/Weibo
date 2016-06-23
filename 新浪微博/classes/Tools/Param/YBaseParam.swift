//
//  YBaseParam.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
// 参数基类

import UIKit

class YBaseParam: NSObject {
    ///采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    var access_token: String = YAccountTool.account()!.access_token

}
