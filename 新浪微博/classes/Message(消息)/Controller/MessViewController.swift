//
//  MessViewController.swift
//  新浪微博
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 yygs. All rights reserved.
//

import UIKit

class MessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let label = UILabel(frame: CGRectMake(90, 90, 50, 30))
        label.text = "Mess"
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /**
    点击发送消息触发的事件
    
    - parameter sender: <#sender description#>
    */
    func sendMess(sender:YBarButtonItem_Title){
        print("点击了发送消息")
    }
}
