//
//  YAccountParam.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YAccountParam: NSObject {
    /// client_id 	true 	string 	申请应用时分配的AppKey。
    var client_id: String = YAppKey
    ///   client_secret 	true 	string 	申请应用时分配的AppSecret。
    var client_secret: String = YAppSecret
    ///  grant_type 	true 	string 	请求的类型，填写authorization_code
    var grant_type: String = "authorization_code"
    ///   code 	true 	string 	调用authorize获得的code值。
    var code: String = ""
    /// redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
    var redirect_uri: String = YRedirectURI
  

}
