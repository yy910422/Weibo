//
//  YAccountTool.swift
//  新浪微博
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation

class YAccountTool: NSObject {
    class func saveAccount(account: OAuthModel)-> Bool{
        let modelData = NSKeyedArchiver.archivedDataWithRootObject(account)
        NSUserDefaults.standardUserDefaults().setValue(modelData, forKey: "account")
        return true
    }
    class func account() -> OAuthModel?{
        let modelData = NSUserDefaults.standardUserDefaults().valueForKey("account")
        if modelData != nil {
            let model = NSKeyedUnarchiver.unarchiveObjectWithData(modelData as! NSData)
                as! OAuthModel
            if NSDate().compare(model.expires_data) != NSComparisonResult.OrderedAscending{
                //过期
                return nil
            }
            return model
        }
        return nil
    }
     /*
      *版本检查
      */
    class func checkVersion(){
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let appVersion = userDefault.stringForKey("appVersion")
        
        if appVersion == nil || appVersion != currentAppVersion {
            userDefault.setValue(currentAppVersion, forKey: "appVersion")
            let rootView = YNewFeatureController()
            KeyWindow?.rootViewController = rootView
        }else{
            let rootTabVC =  YTabBarController.shareSingle()
            //rootTabVC.dataSource = modelArray
            KeyWindow?.rootViewController = rootTabVC
        }
    }
    /**
     通过code获取acess_token
     
     - parameter code:    <#code description#>
     - parameter success: 成功调用的closure
     - parameter failure: 失败时调用的closure
     */
    class func accountWithCode(code: String,success:(()->Void)!,failure: ((NSError!)-> Void)?){
        
        let param = YAccountParam()
        param.code = code
        YHttpRequest.Post(URL_YAccessToken, params: param.mj_keyValues(), success: { (data) -> Void in
            let model = OAuthModel.mj_objectWithKeyValues(data)
            print(data)
            YAccountTool.saveAccount(model)
            success()
            }) { (error) -> Void in
                if failure != nil {
                    failure!(error)
                }
        }
        
    }
    
}
