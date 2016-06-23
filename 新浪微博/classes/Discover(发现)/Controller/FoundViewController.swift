//
//  FoundViewController.swift
//  新浪微博
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 yygs. All rights reserved.
//

import UIKit
import AsyncDisplayKit
class FoundViewController: UIViewController {

    var asTableView: ASTableView!
    override required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        asTableView = ASTableView()
        
        super.init(nibName: nil, bundle: nil)
        asTableView.asyncDataSource = self
        asTableView.asyncDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.addSubview(self.asTableView!)
        let searchTextField = YSearchBar(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,35))
        searchTextField.placeholder = "大家正在搜：土耳其进军"
        self.navigationItem.titleView = searchTextField
    }
    
    override func viewWillLayoutSubviews() {
        self.asTableView.frame = self.view.bounds
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
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

}

extension FoundViewController: ASTableViewDelegate,ASTableViewDataSource{

    func tableView(tableView: ASTableView!, didEndDisplayingNodeForRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    func tableView(tableView: ASTableView!, willDisplayNodeForRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let node = ASTextCellNode()
        node.text = "这是第\(indexPath.row)行"
        return node
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
}
