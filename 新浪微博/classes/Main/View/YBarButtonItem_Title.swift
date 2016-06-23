//
//  YBarButtonItem.swift
//  新浪微博
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YBarButtonItem_Title: UIBarButtonItem {


    override init() {
        super.init()
    }
    convenience init(title:String,target:AnyObject?,action:Selector){
        self.init()
        self.title = title
        self.target = target
        self.action = action
        self.style = .Plain
        self.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Normal)
       // super.init(title: title, style: UIBarButtonItemStyle.Plain, target: target, action: action)
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

}
