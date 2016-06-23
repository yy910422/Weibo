//
//  YStatusNode.swift
//  新浪微博
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 yygs. All rights reserved.
//  自定义的cellnode

import UIKit
import AsyncDisplayKit
class YStatusNode: ASCellNode {
/*
    ASCellNode的生命周期
    init -> didLoad -> caaculateSizeThatFits -> layout -> showViews(clearViews) -> deinit
    */
//    calculateSizeThatFits
    
//    //原创
//    var originalView = ASDisplayNode { () -> UIView! in
//        let view = YOriginalView()
//        return view
//    }
//    //转发
//    var retweetView = ASDisplayNode { () -> UIView! in
//        let view = YRetweetView()
//        return view
//    }
//    //工具条
//    var toolBar = ASDisplayNode { () -> UIView! in
//        let view = YStatusToolBar()
//        return view
//    }
    var originalView = YOriginalView(frame: CGRect.zero)
    
    var retweetView = YRetweetView(frame: CGRect.zero)
    
     var toolBar = YStatusToolBar(frame: CGRect.zero)
    
    var viewModel: YStatusViewModel!{
        didSet{
            originalView.viewModel = viewModel
            toolBar.status = viewModel.status
            if viewModel.status.retweeted_status != nil {
                retweetView.viewModel = viewModel
            }
            setUpAllChildView()
        }
    }
    
    
    /**
     添加所有子控件
     */
    func setUpAllChildView(){
        //原创微博
        self.view.addSubview(originalView)
        if viewModel.status.retweeted_status != nil {
            //转发微博
            self.view.addSubview(retweetView)
        }
        //工具条
        self.view.addSubview(toolBar)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        return CGSize(width: constrainedSize.width, height: viewModel.cellHeight)
    }
    
//    let activityIndicator = ASDisplayNode { () -> UIView! in
//        let view = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
//        view.backgroundColor = UIColor.clearColor()
//        view.hidesWhenStopped = true
//        return view
//    }
    
    override init!() {
        super.init()
        //addSubnode()
    }
    
    func resume(){

    }
    
//    func startAnimating(){
//        if let acitvityIndicatorView = activityIndicator.view as? UIActivityIndicatorView {
//            acitvityIndicatorView.startAnimating()
//        }
//    }
    override func layout() {
        //设置原创微博的frame
        originalView.frame = viewModel.originalViewFrame
        if viewModel.status.retweeted_status != nil {
            //设置转发微博的frame
            retweetView.frame = viewModel.retweetViewFrame
        }
        //设置工具条的frame
        toolBar.frame = viewModel.toolBarFrame
    }
}
