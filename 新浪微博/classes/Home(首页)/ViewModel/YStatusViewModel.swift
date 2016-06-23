//
//  YStatusViewModel.swift
//  新浪微博
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 yygs. All rights reserved.
//  包含对应模型 + 对应控件的frame

import UIKit

class YStatusViewModel: NSObject {
    
  
    //计算cell的子控件frame
    
    //原创微博
    var originalViewFrame: CGRect!
    
    /*   ***********原创微博子控件的frame**********  */
    /// 头像的frame
    var originalIconFrame: CGRect!
    /// 昵称的frame
    var originalNameFrame: CGRect!
    /// vip的frame
    var originalVipFrame: CGRect!
    /// 时间的frame
    var originalTimeFrame: CGRect!
    /// 来源的frame
    var originalSourceFrame: CGRect!
    /// 正文的frame
    var originalTextFrame: CGRect!
    
    /// 配图的frame
    var originalPhotosFrame: CGRect!
    
    
    
    //转发微博
    var retweetViewFrame: CGRect!
    
    /// 转发微博昵称的frame
    var retweetNameFrame: CGRect!
    
    //转发微博正文的frame
    var retweetTextFrame: CGRect!

    /// 转发微博的配图的frame
    var retweetPhotosFrame: CGRect!
    //工具条
    var toolBarFrame: CGRect!
    //cell的高度
    var cellHeight: CGFloat!
    
    /// 微博数据
    var status: YStatus!{
        didSet{
            //计算原创微博
            setUpOriginalViewFrame()
            var toolBarY = CGRectGetMaxY(originalViewFrame)
            //计算转发微博
            if status.retweeted_status != nil {
                setUpRetweetViewFrame()
                toolBarY = CGRectGetMaxY(retweetViewFrame)
            }
            //计算工具条
            let toolBarX: CGFloat = 0
            let toolBarW = YMainScreen.bounds.size.width
            let toolBarH: CGFloat = 35
            toolBarFrame = CGRectMake(toolBarX,toolBarY,toolBarW,toolBarH)
            //计算cell高度
            cellHeight = CGRectGetMaxY(toolBarFrame)
        }
    }
    
    /**
     计算原创微博frame
     */
    func setUpOriginalViewFrame(){
    
        
        //头像
        let imageX = CGFloat(YStatusImageX)
        let imageY = imageX
        let imageWH: CGFloat = 35
        
        originalIconFrame = CGRectMake(imageX,imageY,imageWH,imageWH)
        
        //昵称
        
        let nameX = CGRectGetMaxX(originalIconFrame) + CGFloat(YStatusCellMargin)
        let nameY = imageY
        let nameSize = (status.user.name as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13)])
        
        originalNameFrame = CGRect(origin: CGPoint(x: nameX,y: nameY), size: nameSize)
        
        //vip
        
        if status.user.vip {
            let vipX = CGRectGetMaxX(originalNameFrame) + CGFloat(YStatusCellMargin)
            let vipY = nameY
            let vipWH: CGFloat = 14
            originalVipFrame = CGRectMake(vipX,vipY,vipWH,vipWH)
        }
        
        //时间

//        let timeX = nameX
//        let timeY = CGRectGetMaxY(originalNameFrame) + CGFloat(YStatusCellMargin)
//        let timeSize = (status.created_at_fmt as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13)])
//        originalTimeFrame = CGRect(origin: CGPoint(x: timeX,y: timeY), size: timeSize)
        
        //来源
        
//        let sourceX = CGRectGetMaxX(originalTimeFrame) + CGFloat(YStatusCellMargin)
//        let sourceY = timeY
//        let sourceSize = (status.source as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(12)])
//        originalSourceFrame = CGRect(origin: CGPoint(x: sourceX,y: sourceY), size: sourceSize)
        
        //正文
        
        let textX = imageX
        let textY = CGRectGetMaxY(originalIconFrame) + CGFloat(YStatusCellMargin)
        let textW = YMainScreen.bounds.size.width - CGFloat(2 * YStatusCellMargin)
        let textH = textHeightFromTextString(status.text, textWidth: textW, fontSize: 15, isBold: false)
        
        originalTextFrame = CGRectMake(textX,textY,textW,textH)
        
        
        //原创微博的frame
        let originX: CGFloat = 0
        let originY: CGFloat = 10
        let originW = YMainScreen.bounds.size.width
        var originH = CGRectGetMaxY(originalTextFrame) + CGFloat(YStatusCellMargin)
        //配图
        if status.pic_urls.count > 0 {
            let photosX = CGFloat(YStatusCellMargin)
            let photosY = CGRectGetMaxY(originalTextFrame) +  CGFloat(YStatusCellMargin)
            let photosSize = photosSizeWithCount(status.pic_urls.count)
            originalPhotosFrame = CGRect(origin: CGPoint(x: photosX, y: photosY), size: photosSize)
            originH = CGRectGetMaxY(originalPhotosFrame) + CGFloat(YStatusCellMargin)
        }else{
            originalPhotosFrame = CGRect.zero
        }
        
       
        
        originalViewFrame = CGRectMake(originX,originY,originW,originH)
        
    }
    /**
     计算配图的尺寸
     
     - parameter count: 配图数
     
     - returns: <#return value description#>
     */
    func photosSizeWithCount(count: Int) -> CGSize {
        let cols = count == 4 ? 2 : 3
        let rols = (count - 1) / cols + 1
        
        let width = CGFloat(cols * 70 ) + CGFloat(cols - 1) * CGFloat(YStatusCellMargin)
        let height = CGFloat(rols * 70) +  CGFloat(rols - 1) * CGFloat(YStatusCellMargin)
        return CGSizeMake(width, height)
    }
    /**
     计算转发微博frame
     */
    func setUpRetweetViewFrame(){
        //昵称
        
        let nameX = CGFloat(YStatusCellMargin)
        let nameY = nameX
        let nameSize = (status.retweeted_name as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13)])
        retweetNameFrame = CGRect(origin: CGPoint(x: nameX,y: nameY), size: nameSize)
        
        //正文
        
        let textX = nameX
        let textY = CGRectGetMaxY(retweetNameFrame) + CGFloat(YStatusCellMargin)
        let textW = YMainScreen.bounds.size.width - CGFloat(2 * YStatusCellMargin)
        let textH = textHeightFromTextString(status.retweeted_status!.text, textWidth: textW, fontSize: 15, isBold: false)
        
        retweetTextFrame = CGRectMake(textX,textY,textW,textH)
        //转发微博的frame
        let retweetX: CGFloat = 0
        let retweetY = CGRectGetMaxY(originalViewFrame)
        let retweetW = YMainScreen.bounds.size.width
        var retweetH = CGRectGetMaxY(retweetTextFrame) + CGFloat(YStatusCellMargin)
        
        
        //配图
        if status.retweeted_status!.pic_urls.count > 0 {
            let photosX = CGFloat(YStatusCellMargin)
            let photosY = CGRectGetMaxY(retweetTextFrame) +  CGFloat(YStatusCellMargin)
            let photosSize = photosSizeWithCount(status.retweeted_status!.pic_urls.count)
            retweetPhotosFrame = CGRect(origin: CGPoint(x: photosX, y: photosY), size: photosSize)
            retweetH = CGRectGetMaxY(retweetPhotosFrame) + CGFloat(YStatusCellMargin)
        }else{
            retweetPhotosFrame = CGRect.zero
        }
        retweetViewFrame = CGRectMake(retweetX,retweetY,retweetW,retweetH)
    }
    
    /**
     根据字体和文本内容 自动获取高度
     
     - returns: <#return value description#>
     */
    func textHeightFromTextString(text: String, textWidth: CGFloat, fontSize: CGFloat, isBold: Bool) -> CGFloat
    {
        
        if (getCurrentIOS() >= 7.0)
        {
            //iOS7之后
            var dict: NSDictionary = NSDictionary()
            if (isBold) {
                dict = NSDictionary(object: UIFont.boldSystemFontOfSize(fontSize), forKey: NSFontAttributeName)
                
            } else {
                dict = NSDictionary(object: UIFont.systemFontOfSize(fontSize), forKey: NSFontAttributeName)
                
            }
            
            let rect: CGRect = (text as NSString).boundingRectWithSize(CGSizeMake(textWidth, CGFloat(MAXFLOAT)), options: [NSStringDrawingOptions.TruncatesLastVisibleLine, NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesLineFragmentOrigin], attributes: dict as? [String : AnyObject], context: nil)
            return rect.size.height
        } else
        {
            //iOS7之前
            
            
            return 0.0
        }
        
    }
    //MARK: - 获取版本号
    func getCurrentIOS() -> Double
    {
        
        return (UIDevice.currentDevice().systemVersion as NSString).doubleValue
        
    }
}
