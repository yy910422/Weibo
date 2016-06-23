//
//  YTabBarModel.swift
//  test
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 yygs. All rights reserved.
//

import Foundation


class YTabBarModel {
    
    init(){
        
    }
    
    init(view:UIViewController,title:String?,image:String?,selectedImage:String?,fontColor:UIColor?,addNavigation:Bool?,rightBarButtonItem:UIBarButtonItem? = nil,leftBarButtonItem:UIBarButtonItem? = nil){
        self.view = view
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.fontColor = fontColor
        if addNavigation != nil {
            self.addNavigation = addNavigation!
            if rightBarButtonItem != nil {
                view.navigationItem.rightBarButtonItem = rightBarButtonItem
            }
            if leftBarButtonItem != nil {
                view.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        }
       
    }
    //主视图
    var view: UIViewController?
    var title: String?{
        didSet{
            view?.title = title
        }
    }
    var image: String?
    var selectedImage: String?
    var fontColor: UIColor?
    //添加navigation
    var addNavigation: Bool = false{
        didSet{
            if addNavigation {
                //禁用系统自动为添加Navigation的页面下移64px的偏移量
                //但是由于TabBar的存在，所以底部需要系统自动偏移
                view?.edgesForExtendedLayout = UIRectEdge.Bottom
            }
        }
    }
    //给navigation添加右侧按钮
    var rightBarButtonItem: UIBarButtonItem? {
        didSet{
            view?.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    //给navigation添加左侧按钮
    var leftBarButtonItem: UIBarButtonItem? {
        didSet{
            view?.navigationItem.leftBarButtonItem = leftBarButtonItem
        }
    }
}