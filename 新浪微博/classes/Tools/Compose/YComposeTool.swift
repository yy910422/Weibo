//
//  YComposeTool.swift
//  新浪微博
//
//  Created by bg on 16/5/3.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YComposeTool: NSObject {

    class func composeWithStatus(status: String, success:()-> Void,failure: ((NSError!) -> Void)!){
        let param = YComposeParam()
        param.status = status
        YHttpRequest.Post(URL_YUpdate, params: param.mj_keyValues(), success: { (data) in
            success()
            }) { (err) in
                failure(err)
        }
    }
    class func composeWithPicStatus(status: String,pic: NSData,success:()-> Void,failure: ((NSError!) -> Void)!){
        let param = YComposePicParam()
        param.status = status
        param.pic = pic
        YHttpRequest.Post(URL_YUpload, params: param.mj_keyValues(), success: { (data) in
            success()
        }) { (err) in
            failure(err)
        }
        
    }
    
}
