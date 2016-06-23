//
//  YUserTool.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YUserTool: NSObject {
    
    /**
     请求用户的未读数
     
     - parameter success: 成功时调用的closure
     - parameter failure: 失败是调用的closure
     */
    class func unreadWithSuccess(success:((YUserResult)->Void)!,failure:((NSError!)->Void)?){
        let param = YUserParam()
        param.uid = YAccountTool.account()!.uid
        YHttpRequest.Get(URL_YUnreadCount, params: param.mj_keyValues(), success: { (data) -> Void in
            let result = YUserResult.mj_objectWithKeyValues(data)
            success(result)
            
            }) { (error) -> Void in
                
        }
        
    }
    /**
     获取用户信息
     
     - parameter success: 成功的回调
     - parameter failure: 失败的回调
     */
    class func userInfoWithSuccess(success:((YUser)->Void)!,failure:((NSError!)->Void)?){
        let param = YUserParam()
        param.uid = YAccountTool.account()!.uid
        YHttpRequest.Get(URL_YUserShow, params: param.mj_keyValues(), success: { (data) -> Void in
            let result = YUser.mj_objectWithKeyValues(data)
            success(result)
            }) { (error) -> Void in
                if failure != nil {
                    failure!(error)
                }
        }
    }

}
