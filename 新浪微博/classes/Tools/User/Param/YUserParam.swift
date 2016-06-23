//
//  YUserParam.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//用户未读数请求的参数

import UIKit

class YUserParam: YBaseParam {
   
    /// 需要获取消息未读数的用户UID，必须是当前登录用户。
    var uid: String = ""
    /// 未读数版本。0：原版未读数，1：新版未读数。默认为0。
    var unread_message: Int?
}
