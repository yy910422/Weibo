
import Foundation

class HomeViewModel:BaseViewModel,YTableViewModelDelegate {
    
    /// 数据源，放的时viewmodel模型
    var array: NSMutableArray?
    //viewModel的代理Controller
    var delegate: UIViewController!
    
    //单例
    class var sharedInstance: HomeViewModel {
        dispatch_once(&Inner.token) {
            Inner.instance = HomeViewModel()
        }
        return Inner.instance!
    }
    struct Inner {
        static var instance: HomeViewModel?
        static var token: dispatch_once_t = 0
    }
    
    private override init() {
        super.init()
        array = []
        
    }
    
    /**
     获取更多微博数据/Users/apple/Desktop/新浪微博/新浪微博/classes/Tools/Http/YHttpRequest.swift
     
     - parameter tableView: 需要更新的tableView
     */
    func loadMoreStatus(tableView: UITableView){
        let param = YStatusParam()
        if self.array?.count > 0 {
            //指定此参数，会返回比这个id新的微博数据
            let maxId = ((self.array?.lastObject as! YStatusViewModel).status.idstr as NSString).longLongValue - 1
            param.max_id = "\(maxId)"
        }
        self.getDataList(YStatusesFriends_timeline, params:param.mj_keyValues() , success: { (data) -> Void in
            //接收到的数据
            let statusResult = YStatusResult.mj_objectWithKeyValues(data)
            let indexSet = NSIndexSet(indexesInRange: NSMakeRange(0,statusResult.statuses.count))
           
            //转换成viewmodel
            let statusesFrames = NSMutableArray()
            for val in statusResult.statuses {
                let model = YStatusViewModel()
                model.status = val as! YStatus
                statusesFrames.addObject(model)
            }
            self.array?.insertObjects(statusesFrames as [AnyObject], atIndexes: indexSet)
            tableView.reloadData()
            tableView.footer.endRefreshing()
            }) { (error) -> Void in
                print(error)
        }
    }
    
    /**
     获取更新的微博数据
     
     - parameter tableView: 需要更新的tableView
     */
    func loadNewStatus(tableView: UITableView){
        let param = YStatusParam()
        if self.array?.count > 0 {
            //指定此参数，会返回比这个id新的微博数据
            param.since_id = (self.array![0] as! YStatusViewModel).status.idstr
        }
        self.getDataList(YStatusesFriends_timeline, params: param.mj_keyValues(), success: { (data) -> Void in
            //接收到的数据
            let statusResult = YStatusResult.mj_objectWithKeyValues(data)
            //把最新的微博数插入到最前面
            let indexSet = NSIndexSet(indexesInRange: NSMakeRange(0,statusResult.statuses.count))
            //提示更新了X条微博
            if self.array?.count > 0 {
                self.showNewStatusCount(statusResult.statuses.count)
            }
            
            //转换成viewmodel
            let statusesFrames = NSMutableArray()
            for val in statusResult.statuses {
                let model = YStatusViewModel()
                model.status = val as! YStatus
                statusesFrames.addObject(model)
            }
            self.array?.insertObjects(statusesFrames as [AnyObject], atIndexes: indexSet)
            tableView.reloadData()
            tableView.header.endRefreshing()
            }) { (error) -> Void in
                print(error)
        }
    }
    
    func showNewStatusCount(count: Int){
        guard count > 0 else {
            return
        }
        let h: CGFloat = 35
        let y = CGRectGetMaxY(self.delegate.navigationController!.navigationBar.frame) - h
        let x:CGFloat = 0
        let w = self.delegate.view.width
        let label = UILabel(frame:CGRectMake(x,y,w,h))
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_new_status_background")!)
        label.text = "更新了\(count)条微博"
        //添加到导航控制器下导航条的下面
        self.delegate.navigationController!.view.insertSubview(label, belowSubview: self.delegate.navigationController!.navigationBar)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            label.transform = CGAffineTransformMakeTranslation(0, h)
            }) { (finished) -> Void in
                //往上面平移
                UIView.animateWithDuration(0.25, delay: 2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    //还原
                    label.transform = CGAffineTransformIdentity
                    }, completion: { (finished) -> Void in
                        label.removeFromSuperview()
                })
        }
        
    }
    
    //TableView的一些协议方法*******************
    
    func numOfSections() -> Int {
        return 1
    }
    func numOfRowsInSection(section: Int) -> Int{
        return array!.count
    }
    
    func heightForRowAtIndexPath (indexPath: NSIndexPath) -> CGFloat{
        return 45
    }
    
    func itemAtIndex(index: NSIndexPath) -> AnyObject {
        return array![index.row]
    }
    
    func heightForFooterInSection(section: Int) -> CGFloat {
        return 0
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        return 0
    }
}