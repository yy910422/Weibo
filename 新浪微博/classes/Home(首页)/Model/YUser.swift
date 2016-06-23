//
//  YUser.swift
//  新浪微博
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation

class YUser: NSObject {
    /*
     * 昵称
     */
    var name: String = ""
    /*
    * 微博头像
    */
    var profile_image_url: String = ""
    /// 会员类型 >2代表是会员
    var mbtype: Int = 0
 /// 会员等级
    var mbrank: Int = 0
    //是否是会员
    var vip: Bool {
        get {
            return mbtype > 2
        }
    }
}
