//
//  YTitleButton.swift
//  新浪微博
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 内部图标居中
        self.imageView!.contentMode = .Center
        // 文字对齐
        self.titleLabel!.textAlignment = .Right
        // 文字颜色
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        // 字体
    
        self.titleLabel!.font = YNavigationTitleFont
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = false
    }
    /**
     *  设置内部图标的frame
     */
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageY: CGFloat = 0
        let imageW: CGFloat = self.height
        let imageH: CGFloat = imageW
        let imageX = self.width - imageW
        return CGRectMake(imageX, imageY, imageW, imageH)
    }
    /**
     *  设置内部文字的frame
     */
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleY: CGFloat = 0
        let titleX: CGFloat = 0
        let titleH: CGFloat = self.height
        let titleW = self.width - self.height
        return CGRectMake(titleX, titleY, titleW, titleH)
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        let titleSize = NSString(CString: (title?.cStringUsingEncoding(NSUTF8StringEncoding))!, encoding: NSUTF8StringEncoding)?.sizeWithAttributes([NSFontAttributeName:YNavigationTitleFont])
        //let titleSize = (title as! NSString).sizeWithAttributes([NSFontAttributeName:YNavigationTitleFont])
        self.width = titleSize!.width + self.height + 10
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
