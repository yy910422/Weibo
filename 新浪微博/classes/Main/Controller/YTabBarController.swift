//
//  YTabBarController.swift
//  test
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YTabBarController: UITabBarController {
    /**
     单例创建TabBar
     
     - parameter datasource: <#datasource description#>
     
     - returns: <#return value description#>
     */
    class func shareSingle()-> YTabBarController {
        struct temps {
            static var instance: YTabBarController?
            static var myT : dispatch_once_t = 0
//            static var dataInstance: [YTabBarModel]?
        }
        dispatch_once(&temps.myT) { () -> Void in
            NSThread.sleepForTimeInterval(1)
            temps.instance = YTabBarController()
//            temps.dataInstance = datasource
//            temps.instance?.dataSource = datasource
        }
        return temps.instance!
    }
    weak var selectedButton: UIButton?
    
    //初始化子视图list
    var dataSource: [YTabBarModel]?{
        didSet{
            for val in dataSource! {
                addChildTabBar(val.view!, title: val.title!, image: val.image!, selectedImage: val.selectedImage!, fontColler:val.fontColor ?? UIColor.orangeColor(),setNavigation: val.addNavigation)
            }
        }
    }
    
    
    //首页
    let view1 = HomeViewController()
    //消息
    let view2 = MessViewController()
    //发现
    let view3 = FoundViewController()
    //我
    let view4 = MyViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //将tabbar替换成自定义的微博样式的tabbar
        let tabBar = YTabBar(frame:self.tabBar.frame)
        tabBar.plusBtnClickAction =  plusBtnClickAction
        self.setValue(tabBar, forKey: "tabBar")
        //objc_msgSend(self,@selector(setTabBar:),tabBar)
        
        //每隔一段时间就应该请求一次，用NSTimer
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "requestUnread", userInfo: nil, repeats: true)
      
        setUpTabBar()
    }
    
    //点击中间加号按钮的事件
    func plusBtnClickAction() {
        let composeViewController = YComposeViewController()
        let navController = YNavigationController(rootViewController: composeViewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func requestUnread(){
        YUserTool.unreadWithSuccess({ (model) -> Void in
            self.view1.tabBarItem.badgeValue = model.status > 0 ? "\(model.status)" : nil
            self.view2.tabBarItem.badgeValue = model.messageCount > 0 ? "\(model.messageCount!)" : nil
            self.view4.tabBarItem.badgeValue = model.follower > 0 ? "\(model.follower)" : nil
            
            //设置应用程序所有的未读数
            UIApplication.sharedApplication().applicationIconBadgeNumber = model.totalCount!
            }) { (error) -> Void in
                
        }
    }
    
    func setUpTabBar(){
        //消息页面的发送消息按钮
        let sendMessBarItem = YBarButtonItem_Title(title: "发送消息", target: view2, action: "sendMess:")
        //我页面的设置按钮
        let proSetBarItem = YBarButtonItem_Title(title: "发送消息", target: view4, action: "setUpPro:")
        
        
        let model1 = YTabBarModel(view: view1, title: "首页", image: "tabbar_home", selectedImage: "tabbar_home_selected", fontColor: nil, addNavigation: true, rightBarButtonItem:UIBarButtonItem.item(view1, action: "Flicking", image: "navigationbar_pop", highImage: "navigationbar_pop_highlighted"), leftBarButtonItem: UIBarButtonItem.item(view1, action: "Addbuddy", image: "navigationbar_friendsearch", highImage: "navigationbar_friendsearch_highlighted"))
        let model2 = YTabBarModel(view: view2, title: "消息", image: "tabbar_message_center", selectedImage: "tabbar_message_center_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: sendMessBarItem, leftBarButtonItem: nil)
        let model3 = YTabBarModel(view: view3, title: "搜索", image: "tabbar_discover", selectedImage: "tabbar_discover_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: nil, leftBarButtonItem: nil)
        let model4 = YTabBarModel(view: view4, title: "我", image: "tabbar_profile", selectedImage: "tabbar_profile_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: proSetBarItem, leftBarButtonItem: nil)
        let modelArray = [model1,model2,model3,model4]
        self.dataSource = modelArray
    }
    
    //已经弃用的方法
    func clickBtn(sender:UIButton){
        self.selectedButton?.selected = false
        
        sender.selected = true
        self.selectedButton = sender
        
        self.selectedIndex = sender.tag
    }
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if( item == tabBar.items!.first && selectedIndex == 0) {
            view1.refresh()
        }
    }
    //添加子视图的方法
    func addChildTabBar(childViewController:UIViewController,title:String,image:String,selectedImage:String,fontColler:UIColor,setNavigation: Bool = false){
        
        
        childViewController.tabBarItem.title = title
        
        childViewController.tabBarItem.image = UIImage(named: image)
        
        var selectedText = [String : AnyObject]()
        
        selectedText[NSForegroundColorAttributeName] = fontColler
        
        childViewController.tabBarItem.setTitleTextAttributes(selectedText, forState: UIControlState.Selected)
        
        childViewController.tabBarItem.selectedImage = UIImage.imageWithOriginalMode(selectedImage)
        if setNavigation {
            //UINavigationController会调用底层的push方法
            let nv = YNavigationController(rootViewController: childViewController)
            childViewController.title = title
            
            self.addChildViewController(nv)

        }else{
            self.addChildViewController(childViewController)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}