//
//  YCollectionViewCell.swift
//  新浪微博
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YCollectionViewCell: UICollectionViewCell {
    
    weak var _shareButton: UIButton?
    weak var _startButton: UIButton?
    weak var _imageView: UIImageView?
    var _image: UIImage?
    //分享按钮
    var shareButton: UIButton {
        get{
            if _shareButton == nil {
               let btn = UIButton(type: .Custom)
                btn.setTitle("分享给大家", forState: .Normal)
                btn.setImage(UIImage(named: "new_feature_share_false"), forState: .Normal)
                btn.setImage(UIImage(named: "new_feature_share_true"), forState: .Selected)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.addTarget(self, action: "didSelected:", forControlEvents: .TouchUpInside)
                btn.sizeToFit()
                self.contentView.addSubview(btn)
                _shareButton = btn;
            }
            return _shareButton!
        }
    }
    func didSelected(sender:UIButton){
        if shareButton.selected {
            shareButton.selected = false
        }else{
            shareButton.selected = true
        }
    }
    
    var startButton: UIButton{
        get{
            if _startButton == nil {
                let btn = UIButton(type: .Custom)
                btn.setTitle("开始微博", forState: .Normal)
                btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
                btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
                btn.sizeToFit()
                btn.addTarget(self, action: "startApp:", forControlEvents: .TouchUpInside)
                self.addSubview(btn)
                _startButton = btn
            }
            return _startButton!
        }
    }
    var imageView: UIImageView{
        get{
            if _imageView == nil {
                let imgV = UIImageView()
                imgV.userInteractionEnabled = true
                self.contentView.addSubview(imgV)
                _imageView = imgV
            }
            return _imageView!
        }
    }
    
    var image:UIImage?{
        get{
            return _image
        }
        set{
            _image = newValue
            self.imageView.image = newValue
        }
    }
    
    func setIndexPath(indexPath:NSIndexPath,count:Int){
        if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
            self.shareButton.hidden = false
            self.startButton.hidden = false
            
            
        }else{ // 非最后一页，隐藏分享和开始按钮
            self.shareButton.hidden = true
            self.startButton.hidden = true
        }
    }
    
    //设置各控件的布局
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
        // 分享按钮
        self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8)
        // 开始按钮
        self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9)
    }
    //进入主页面
    func startApp(sender:UIButton){
        let rootTabVC =  YTabBarController.shareSingle()
        //rootTabVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
   
        KeyWindow?.rootViewController = rootTabVC
    }
}
