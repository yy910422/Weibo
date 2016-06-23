//
//  YRetweetView.swift
//  新浪微博
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YRetweetView: UIImageView {
    
    var nameView: UILabel!
    var textView: UILabel!
    
    /// 配图
    var photosView: YPhotosView!
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var viewModel: YStatusViewModel!{
        didSet{
            nameView.frame = viewModel.retweetNameFrame
            nameView.text = viewModel.status.retweeted_name
            
            textView.frame = viewModel.retweetTextFrame
            textView.text = viewModel.status.retweeted_status?.text
            
            photosView.frame = viewModel.retweetPhotosFrame
            photosView.pic_urls = viewModel.status.retweeted_status?.pic_urls
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加所有子控件
        setUpAllChildView()
        self.userInteractionEnabled = true
        self.image = UIImage(named: "timeline_retweet_background")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /**
     添加所有子控件
     */
    func setUpAllChildView(){
      
        //昵称
        nameView = UILabel()
         nameView.font = UIFont.systemFontOfSize(12)
        self.addSubview(nameView)
        //正文
        textView = UILabel()
        textView.font = UIFont.systemFontOfSize(12)
        textView.numberOfLines = 0
        self.addSubview(textView)
        
        photosView = YPhotosView()
        self.addSubview(photosView)
    }
}
