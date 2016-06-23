//
//  YPopMenu.swift
//  新浪微博
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

@objc protocol YPopMenuDelegate{
  optional func popMenuDidDismissed(popMenu:YPopMenu)
}

class YPopMenu: UIView {

    //枚举定义箭头的方向
    enum YPopMenuArrowPosition{
       case Center
       case Left
       case Right
    }
    //Mark->公共属性
    var delegate: YPopMenuDelegate?
    //菜单箭头位置
    var arrowPosition: YPopMenuArrowPosition {
        didSet{
            switch (arrowPosition) {
            case .Center:
                
                self.container!.image = UIImage.resizedImage("popover_background")
            case .Left:
                self.container!.image = UIImage.resizedImage("popover_background_left")
            case .Right:
                self.container!.image = UIImage.resizedImage("popover_background_right")
            }
        }
    }
    var dimBackground: Bool = true{
        didSet{
            if dimBackground {
                self.cover.backgroundColor = UIColor.blackColor()
                self.cover.alpha = 0.3
            } else {
                self.cover.backgroundColor = UIColor.clearColor()
                self.cover.alpha = 1.0
            }
        }
    }
    var background: UIImage!{
        didSet{
            self.container.image = background
        }
    }
    
    //Mark-> 私有属性
    private var contentView: UIView!
    //最底部的遮盖层：屏蔽除菜单以外控件的事件
    weak private var cover: UIButton!
    /*
    容器：容纳具体要显示的内容contentView
    */
    weak private var container: UIImageView!
    
    override init(frame: CGRect) {

        self.arrowPosition = .Center
        super.init(frame:frame)
        let cover = UIButton()
        cover.backgroundColor = UIColor.clearColor()
        cover.addTarget(self, action:"coverClick:", forControlEvents: .TouchUpInside)
        self.addSubview(cover)
        self.cover = cover
        let container = UIImageView()
        container.userInteractionEnabled = true
        self.addSubview(container)
        self.container = container
    }
    
    convenience init(contentView:UIView?){
        self.init(frame:CGRect.zero)
        self.contentView = contentView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cover.frame = self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     pragma mark - 内部方法
     - parameter sender: 触发事件者
     */
    func coverClick(sender:UIButton){
        dismiss()
    }
    
    func showInRect(rect:CGRect){
        // 添加菜单整体到窗口身上
        let window = UIApplication.sharedApplication().windows.last
        self.frame = window!.bounds;
        window?.addSubview(self)
        
        // 设置容器的frame
        self.container.frame = rect
        if self.contentView != nil {
             self.container.addSubview(self.contentView)
        }
        // 设置容器里面内容的frame
        let topMargin: CGFloat = 12
        let leftMargin: CGFloat = 5
        let rightMargin: CGFloat = 5
        let bottomMargin: CGFloat = 8
        if self.contentView != nil {
            self.contentView.y = topMargin
            self.contentView.x = leftMargin
            self.contentView.width = self.container.width - leftMargin - rightMargin
            self.contentView.height = self.container.height - topMargin - bottomMargin
        }
        
    }
    
    func dismiss(){
        self.delegate?.popMenuDidDismissed!(self)
        self.removeFromSuperview()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
