//
//  SDYScrollViewCell.swift
//  test
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class SDYScrollViewCell: UICollectionViewCell {
    var imageURL: String! {
        didSet{
            imgView.sd_setImageWithURL(NSURL(string: imageURL), placeholderImage: UIImage(named: "default.jpg"))
        }
    }
    //MARK: - Private 属性
    private var titleLabel: UILabel!
    private var imgView: UIImageView!
    var title: String!{
        didSet{
            titleLabel.text = title
            titleLabel.hidden = false
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        imgView = UIImageView()
         titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.grayColor()
        titleLabel.alpha = 0.5
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.hidden = true
        titleLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(imgView)
        self.addSubview(titleLabel)
    }
    /**
     带标题的ImgView
     
     - parameter frame: frame
     - parameter title: 标题
     */
    convenience init(frame:CGRect,title:String){
        self.init(frame:frame)
        titleLabel.text = title
        self.title = title
        titleLabel.hidden = false
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        imgView = UIImageView()
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.grayColor()
        titleLabel.alpha = 0.5
        titleLabel.hidden = true
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(imgView)
        self.addSubview(titleLabel)
    }
    //设置子视图的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        print("---------------")
        print(self.bounds)
        imgView.frame = self.bounds
        print(imgView.frame)
        titleLabel.frame = CGRectMake(0, self.bounds.height - 30, self.bounds.width, 30)
        titleLabel.hidden = (title == nil)
    }
}
