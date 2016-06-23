//
//  YStatusCellTableViewCell.swift
//  新浪微博
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YStatusCell: UITableViewCell {
 
    weak var originalView: YOriginalView!
    weak var retweetView: YRetweetView!
    weak var toolBar: YStatusToolBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var status: YStatus! {
        didSet{
            
            //计算每个子控件的位置，必须先计算出每个子控件的frame，才能确定
            //如果再这里计算子控件的位置，会比较消耗性能
            
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //添加所有子控件
        setUpAllChildView()
    }
    /**
        添加所有子控件
     */
    func setUpAllChildView(){
//        //原创微博
//         originalView = YOriginalView()
//        self.addSubview(originalView)
//        //转发微博
//        retweetView = YRetweetView()
//        self.addSubview(retweetView)
//        
//        //工具条
//         toolBar = YStatusToolBar()
//        self.addSubview(toolBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
