//
//  YNavigationController.swift
//  新浪微博
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YNavigationController: UINavigationController,UINavigationControllerDelegate {

    var popDelegate:UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //实现滑动返回功能,只需要清空滑动返回手势的代理
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    
    var yLeftBarButtonItem: UIBarButtonItem?{
        didSet{
            self.topViewController?.navigationItem.leftBarButtonItem = yLeftBarButtonItem
        }
    }
    
    var yRightBarButtonItem: UIBarButtonItem?{
        didSet{
            self.topViewController?.navigationItem.rightBarButtonItem = yRightBarButtonItem
        }
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count == 0 {
            //根控制器
        }else{
            //不是根控制器
            if self.yLeftBarButtonItem == nil {//如果不定制个性化的按钮，就用默认的
                //如果把导航条的返回按钮覆盖，就不会有滑动效果
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.item(self, action: "backToPre:", image: "navigationbar_back", highImage: "navigationbar_back_highlighted")
            }
            if self.yRightBarButtonItem == nil {//如果不定制个性化的按钮，就用默认的
                viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.item(self, action: "backToRoot:", image: "navigationbar_more", highImage: "navigationbar_more_highlighted")
            }

        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //返回上一层
    func backToPre(sender:UIBarButtonItem){
        self.popViewControllerAnimated(true)
    }
    //返回主页面
    func backToRoot(sender:UIBarButtonItem){
        self.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //导航控制器跳转完成的时候会调用这个方法
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers[0]{//self.viewControllers[0]就是根控制器
             self.interactivePopGestureRecognizer?.delegate = popDelegate
        }else{
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
