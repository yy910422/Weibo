//
//  YUserResult.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YUserResult: NSObject {
    /// 新微博未读数
    var status: Int = 0
    /// 新粉丝数
    var follower: Int = 0
    /// 新评论数
    var cmt: Int = 0
    /// 新私信数
    var dm: Int = 0
    /// 新提及我的微博数
    var mention_status: Int = 0
    /// 新提及我的评论数
    var mention_cmt: Int = 0
    /// 消息的总数
    var messageCount: Int? {
        get{
            return self.cmt + self.dm + self.mention_status + self.mention_cmt
        }
    }
    /// 未读数的总数
    var totalCount: Int? {
        get{
            return self.messageCount! + self.status + self.follower
        }
    }
}
