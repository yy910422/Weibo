//
//  YImageView.swift
//  新浪微博
//
//  Created by 于杨 on 16/3/4.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var gifView: UIImageView!
    
    var yPhoto: YPhoto!{
        didSet{
            self.sd_setImageWithURL(yPhoto.thumbnail_pic, placeholderImage: UIImage(named: "timeline_image_placeholder"))
            let urlStr = yPhoto.thumbnail_pic?.absoluteString
            if urlStr!.hasSuffix(".gif"){
                self.gifView.hidden = false
            } else {
                self.gifView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.contentMode = .ScaleAspectFill //等比例缩放直有一边不超过图像大小
        self.clipsToBounds = true
        gifView = UIImageView(image: UIImage(named: "timeline_image_gif"))
        self.addSubview(gifView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.gifView.x = self.width - self.gifView.width
        self.gifView.y = self.height - self.gifView.height
    }

    
}
