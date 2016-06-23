//
//  YStatusToolBar.swift
//  新浪微博
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YStatusToolBar: UIImageView {

    var reweetButton: UIButton!
    
    var array = NSMutableArray()
    var divArray = NSMutableArray()
    
    var status: YStatus! {
        didSet{

            guard status.reposts_count > 0 else {
                return
            }
            var title = "\(status.reposts_count)"
            if status.reposts_count > 10000 {
                let floatCount:CGFloat = CGFloat(Double(status.reposts_count) / 10000.0)
                title = "\(floatCount)万"
            }
            reweetButton.setTitle(title, forState: .Normal)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加所有子控件
        setUpAllChildView()
        self.userInteractionEnabled = true
        
        self.image = UIImage(named: "timeline_card_bottom_background")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     添加所有子控件
     */
    func setUpAllChildView(){
        //转发
        reweetButton = setUpOneButton("转发", image: UIImage(named: "timeline_icon_retweet")!)
        reweetButton.addTarget(self, action: "reweetClick:", forControlEvents: .TouchUpInside)
        //评论
        let commentButton = setUpOneButton("评论", image: UIImage(named: "timeline_icon_comment")!)
        commentButton.addTarget(self, action: "commentClick:", forControlEvents: .TouchUpInside)
        //赞
        let unlinkButton = setUpOneButton("赞", image: UIImage(named: "timeline_icon_unlike")!)
        unlinkButton.addTarget(self, action: "unlinkClick:", forControlEvents: .TouchUpInside)
        
        for var i = 0; i < 2 ; i++ {
            let divideV = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
            self.addSubview(divideV)
            self.divArray.addObject(divideV)
        }
    }
    
    /**
     转发事件
     
     - parameter sender: <#sender description#>
     */
    func reweetClick(sender: UIButton){
        print("点击了")
    }
    /**
     评论事件
     
     - parameter sender: <#sender description#>
     */
    func commentClick(sender: UIButton){
        
    }
    /**
     赞事件
     
     - parameter sender: <#sender description#>
     */
    func unlinkClick(sender: UIButton){
        
    }
    /**
     添加一个按钮
     
     - parameter title: <#title description#>
     - parameter image: <#image description#>
     
     - returns: <#return value description#>
     */
    func  setUpOneButton(title:String,image:UIImage) -> UIButton{
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setImage(image, forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(12)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        self.addSubview(button)
        array.addObject(button)
        return button
    }
    
    override func layoutSubviews() {
        let w = YMainScreen.bounds.size.width / CGFloat(array.count)
        let h = self.height
        let count = array.count
        var x: CGFloat = 0
        let y: CGFloat = 0
        
        for var i = 0 ; i < count ; i++ {
            let btn = self.array[i] as! UIButton
            x = CGFloat(i) * w
            btn.frame = CGRectMake(x, y, w, h)
            
        }
        
        for var i = 0 ; i < divArray.count ; i++ {
            let button = array[i + 1] as! UIButton
            let div = divArray[i] as! UIImageView
            div.x = button.x
           
        }
    }
}
