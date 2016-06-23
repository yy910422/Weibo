//
//  YHttpRequest.swift
//  新浪微博
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit
import Alamofire

class YHttpRequest: NSObject {
    
    /**
     Get方法获取数据
     - parameter url:     服务器地址
     - parameter params:  请求参数(这里会拼接到url中)
     - parameter success: 成功时调用的closure
     - parameter failure: 失败时调用的closure
     */
    class func Get(url: String!, params: NSDictionary, success: ((AnyObject!) -> Void)!, failure: ((NSError!) -> Void)?) {
        request(.GET, url, parameters: params as? [String : AnyObject], encoding: .URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                let dic = response.result.value as! NSDictionary
                success(dic)
            }else{
                if failure != nil && response.result.error != nil {
                    failure!(response.result.error)
                }else{
                    ProgressHUD.showError("网络异常，请求失败", interaction: true)
                }
            }
        }
    }
    /**
     Post方法提交数据
     
     - parameter url:     服务器地址
     - parameter params:  请求参数（这里会添加到http的body中）
     - parameter success: 成功时调用的closure
     - parameter failure: 失败时调用的closure
     */
    class func Post(url: String!, params: NSDictionary, success: ((AnyObject!) -> Void)!, failure: ((NSError!) -> Void)?) {
        request(.POST, url, parameters: params as? [String : AnyObject], encoding: .URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                let dic = response.result.value as! NSDictionary
                success(dic)
            }else{
               if failure != nil && response.result.error != nil {
                    failure!(response.result.error)
                }else{
                    ProgressHUD.showError("网络异常，请求失败", interaction: true)
                }
            }
        }
    }

}
