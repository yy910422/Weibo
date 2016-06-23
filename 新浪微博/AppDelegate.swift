//
//  AppDelegate.swift
//  新浪微博
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 yygs. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var player:AVAudioPlayer!
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //1.设置Action
        let action = UIMutableUserNotificationAction()
        action.identifier = "TextAction"
        //设置action的行为为文本框输入
        if #available(iOS 9.0, *) {
            action.behavior = UIUserNotificationActionBehavior.TextInput
        } else {
            // Fallback on earlier versions
        }
        //设置激活方式
        action.activationMode = UIUserNotificationActivationMode.Background
        //2.设置策略
        let category = UIMutableUserNotificationCategory()
        category.identifier = "TextCategory"
        category.setActions([action], forContext: UIUserNotificationActionContext.Default)
        
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: NSSet(array: [category]) as? Set<UIUserNotificationCategory>)
        //3.通知按照这个策略注册
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        if self.window == nil {
            self.window = UIWindow()
        }
       
        self.window?.frame = UIScreen.mainScreen().bounds//窗口大小等于屏幕的大小
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
        //判断有没有进行授权
        
        if YAccountTool.account() != nil {
            YAccountTool.checkVersion()
        }else{
            let oauthVC = YOAuthViewController()
            self.window?.rootViewController = oauthVC
        }
        
//        let rootView = YNewFeatureController()
//        self.window?.rootViewController = rootView
       
        // Override point for customization after application launch.
        return true
    }
    
    
    //失去焦点
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    var backgroundTask: UIBackgroundTaskIdentifier!
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(1) * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            let notify = UILocalNotification()
            notify.category = "TextCategory"
            notify.alertAction = "TextAction"
            notify.alertBody = "您有一条新消息"
            UIApplication.sharedApplication().presentLocalNotificationNow(notify)
        }
        //开启一个后台任务，时间不确定，优先级比较低，假如系统要关闭应用，首先考虑
        backgroundTask =  application.beginBackgroundTaskWithExpirationHandler { () -> Void in
            //当后台任务结束的时候调用
            application.endBackgroundTask(self.backgroundTask)
        }
        //为了提高后台任务的优先级，欺骗苹果，伪装成后台播放程序
        //苹果会检测程序当时有没有播放音乐，如果没有播放，就会被cut
        //在即将失去焦点的时候，播放音乐 0kb的
        do{
            let url = NSBundle.mainBundle().URLForResource("silence.mp3", withExtension: nil)
            player = try AVAudioPlayer(contentsOfURL: url!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
        }catch{
            
        }
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if #available(iOS 9.0, *) {
           // let response = responseInfo[UIUserNotificationActionResponseTypedTextKey]
        } else {
            // Fallback on earlier versions
        }
    }
    /*
     *收到内存警告
     */
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        //停止所有的下载
        SDWebImageManager.sharedManager().cancelAll()
        //删除缓存
        SDWebImageManager.sharedManager().imageCache.clearMemory()
    }

}

