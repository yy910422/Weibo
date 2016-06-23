//
//  Status.swift
//  新浪微博
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation


class YStatus: NSObject {
    
    /*
     *user 	object 	微博作者的用户信息字段 详细
    */
    var user: YUser!
    /*
    *retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细
    */
    var retweeted_status: YStatus?
    
    /// 转发微博昵称的格式化
    var retweeted_name: String{
        get{
            return "@\(retweeted_status!.user.name)"
        }
    }
    /*
    *created_at 	string 	微博创建时间
    */
    var created_at: String!
    /// 将创建时间进行格式转换
    var created_at_fmt: String{
        get{
                        let dateFormater = NSDateFormatter()
                        dateFormater.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
                        dateFormater.locale = NSLocale(localeIdentifier: "en_US")
            
                        let created_at_date = dateFormater.dateFromString(self.created_at)
                        let resultFormater = NSDateFormatter()
                        if created_at_date!.isThisYear() {
                            //是今年
                            if created_at_date!.isToday(){
                                //是今天
                                let cmp = created_at_date?.deltaWithNow()
                                if cmp?.hour >= 1 {
                                    return "\(cmp!.hour)小时前"
                                }else if cmp?.minute >= 1{
                                    return "\(cmp!.minute)分钟前"
                                }else{
                                    return "刚刚"
                                }
                            }else if created_at_date!.isYesterday() {
                                resultFormater.dateFormat = "昨天  HH:mm"
                                //是昨天
                            }else{
                                //昨天之前
                                resultFormater.dateFormat = "MM-dd HH:mm"
                            }
                        }else{
                            //不是今年
                            resultFormater.dateFormat = "yyyy-MM-dd HH:mm"
                           
                        }
                        
                        return resultFormater.stringFromDate(created_at_date!)
        }
    }
    /*
    *idstr 	string 	字符串型的微博ID
    */
    var idstr: String = ""
    /*
    *text 	string 	微博信息内容
    */
    var text: String = ""
    /*
    * source 	string 	微博来源
    */
    var source: String = ""
    
    /// 将微博来源格式化
    var source_fmt: String {
        get{
            if source != "" {
                
                var range = (source as NSString).rangeOfString(">")
                let source_tmp = (source as NSString).substringFromIndex(range.location + range.length) as NSString
                range = source_tmp.rangeOfString("<")
                return "来自  \(source_tmp.substringToIndex(range.location))"
            }else{
                return ""
            }
        }
    }
    /*
    * reposts_count 	int 	转发数
    */
    var reposts_count: Int = 0
    /*
    * comments_count 	int 	评论数
    */
    var comments_count: Int?
    /*
    * attitudes_count 	int 	表态数
    */
    var attitudes_count: Int?
    
    /*
    * pic_Urls 	NSArray 	配图数组，存放的对象
    */
    var pic_urls: NSArray = NSArray()
    
   override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["pic_urls":YPhoto.self]
    }
}