//
//  YComposePhotosView.swift
//  新浪微博
//
//  Created by bg on 16/4/18.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YComposePhotosView: UIView {

    
    func setImage(image: UIImage){
        let imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //在viewdidload添加子控件 不会掉用layoutsubviews方法
    override func layoutSubviews() {
        super.layoutSubviews()
        let cols = 3
        let margin:CGFloat = 10
        let wh = (self.width - CGFloat(cols - 1) * margin) / CGFloat(cols)
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var col: Int = 0
        var row: Int = 0
        
        for var i = 0; i < self.subviews.count ; i++ {
            let imgV = self.subviews[i] as! UIImageView
            col = i % cols
            row = i / cols
            x = CGFloat(col) * (margin + wh)
            y = CGFloat(row) * (margin + wh)
            imgV.frame = CGRectMake(x,y,wh,wh)
        }
    }

}
