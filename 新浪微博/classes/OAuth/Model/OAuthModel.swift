//
//  OAuthModel.swift
//  新浪微博
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation


class OAuthModel: NSObject,NSCoding{
    var access_token: String = ""
    /// 用户ID
    var uid: String = ""
    var remind_in: String = ""
    /// 昵称
    var name: String = ""
    var expires_data: NSDate{
        get{
            return NSDate.init(timeIntervalSinceNow: NSTimeInterval(expires_in)!)
        }
//        set{
//            self.expires_data = newValue
//        }
    }
    var expires_in: String = ""
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.access_token = aDecoder.decodeObjectForKey(YAccountTokenKey) as! String
        self.expires_in = aDecoder.decodeObjectForKey(YExpiresKey) as! String
        self.uid = aDecoder.decodeObjectForKey(YUidKey) as! String
        self.remind_in = aDecoder.decodeObjectForKey(YRemindKey) as! String
        self.name = aDecoder.decodeObjectForKey(YUserNameKey) as! String
    }
    
    //告诉系统哪个属性需要归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: YAccountTokenKey)
        aCoder.encodeObject(expires_in, forKey: YExpiresKey)
        aCoder.encodeObject(uid, forKey: YUidKey)
        aCoder.encodeObject(remind_in, forKey: YRemindKey)
        aCoder.encodeObject(name,forKey: YUserNameKey)
    }
}