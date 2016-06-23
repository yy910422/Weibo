//
//  YPhotosView.swift
//  新浪微博
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YPhotosView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var pic_urls: NSArray!{
        didSet{
            setUpAllChildView()
            for val in 0..<self.subviews.count {
                let imgV = self.subviews[val] as! YImageView
                if val < pic_urls.count {
                    imgV.hidden = false
                    let photo = pic_urls[val] as! YPhoto
                   
                    imgV.yPhoto = photo
                    let gesture = UITapGestureRecognizer(target: self, action: "tap:")
                    gesture.numberOfTapsRequired = 1
                    imgV.addGestureRecognizer(gesture)
                }else {
                    imgV.hidden = true
                }
             }
        }
    }
    
    func tap(gesture:UITapGestureRecognizer) {
        let tapView = gesture.view as! YImageView
        let matArr = NSMutableArray()
        for (index,val) in pic_urls.enumerate() {
            let yphoto = val as! YPhoto
            let model = MJPhoto()
            var urlStr = yphoto.thumbnail_pic?.absoluteString
            urlStr = urlStr?.stringByReplacingOccurrencesOfString("thumbnail", withString:"bmiddle")
            model.url = NSURL(string: urlStr!)
            model.index = Int32(index)
            model.srcImageView = tapView
            matArr.addObject(model)
        }
        let brower = MJPhotoBrowser()
        brower.photos = matArr as [AnyObject]
        brower.currentPhotoIndex = UInt(tapView.tag)
        brower.show()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    /**
     添加所有的9个子控件
     */
    func setUpAllChildView(){
        
        for index in 1...9 {
            let imgV = YImageView(frame:CGRect.zero)
            imgV.userInteractionEnabled = true
            imgV.tag = index - 1
            self.addSubview(imgV)
        }
        
    }
    /**
     计算尺寸
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = 70
        let h: CGFloat = 70
        let margin: CGFloat = 10
        var col = 0
        var rol = 0
        let cols = pic_urls.count == 4 ? 2 : 3
        
        //计算显示出来的imgV的尺寸
        for val in 0..<pic_urls.count {
            let imgV = self.subviews[val]
            col = val % cols
            rol = val / cols
            x = CGFloat(col) * (w + margin)
            y = CGFloat(rol) * (h + margin)
            imgV.frame = CGRectMake(x, y, w, h)
        }
    }

    
}
