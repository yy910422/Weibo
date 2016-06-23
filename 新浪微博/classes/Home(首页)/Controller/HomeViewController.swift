
import UIKit
import AsyncDisplayKit

class HomeViewController: UIViewController {
    
    var value = 1
    weak var titleButton: YTitleButton?
    let viewModel = HomeViewModel.sharedInstance
    var asTableView	: ASTableView!
    var tableHandler: YTableViewDataDelegate!
    var cellIdentifier = "YCell"
    deinit{
        asTableView.dataSource = nil
        asTableView.delegate = nil
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        asTableView.frame = self.view.bounds
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
      //  asTableView = UITableView()
        
        asTableView = ASTableView()
        asTableView.asyncDataSource = self
        asTableView.separatorStyle = .None
        asTableView.asyncDelegate = self
        asTableView.backgroundColor = UIColor.lightGrayColor()
        //添加下拉刷新
        asTableView.addLegendHeaderWithRefreshingTarget(self, refreshingAction: "loadNewStatus")
        //添加自动刷新
        asTableView.header.beginRefreshing()
        
        //添加上拉加载更多
        asTableView.addLegendFooterWithRefreshingTarget(self, refreshingAction: "loadMoreStatus")
        
        self.view.addSubview(asTableView)
        
        YUserTool.userInfoWithSuccess({ (userResult) -> Void in
            //请求当前账号的用户信息
            //设置导航条的标题
            self.titleButton?.setTitle(userResult.name, forState: .Normal)
            let account = YAccountTool.account()
            account?.name = userResult.name
            YAccountTool.saveAccount(account!)
            }) { (error) -> Void in
                
            }
//            let cellConfig: TableViewCellConfigureClosure = {(indexPath,obj,cell) -> Void in
//                let model = self.viewModel.array![indexPath.row] as! YStatus
//                cell.textLabel?.text = model.user.name
//                cell.selectionStyle = .None
//            }
//            let selectedClosure: DidSelectTableCellClosure = {(TableView,indexPath, obj) -> Void in
//        
//            }
//            //tableView的FooterView
//            let footerViewClosure: ViewForFooterInSectionClosure = {(tableView,section) -> UIView in
//            //点击提交操作触发的事件
//            //action-> () -> Void
//            return UIView()
//            }
//            tableHandler = YTableViewDataDelegate.init(delegate: viewModel, cellClass:YStatusCell.self, cellConfig: cellConfig, didSelectClosure: selectedClosure, headerView: nil, footerView: footerViewClosure)
//            tableHandler?.handleTableViewDataSourceAndDelegate(asTableView)
        
        
//        let label = UILabel(frame: CGRectMake(90, 90, 50, 30))
//        label.text = "Home"
//        self.view.addSubview(label)
//        
//        
//        // Do any additional setup after loading the view.
//        
//        let imageNode = ASImageNode()
//        imageNode.backgroundColor = UIColor.lightGrayColor()
//        imageNode.image = UIImage(named: "new_feature_1")
//        imageNode.frame = CGRectMake(90, 50, 200, 200)
//        self.view.addSubview(imageNode.view)
//        
//    
//        let shuffleNode = ASTextNode()
//        let attrs: NSDictionary = [NSFontAttributeName: UIFont.systemFontOfSize(20),NSForegroundColorAttributeName: UIColor.redColor()]
//        shuffleNode.backgroundColor = UIColor.blackColor()
//        let string = NSAttributedString(string: "lgkhkhkyihknk", attributes: attrs as? [String : AnyObject])
//        shuffleNode.attributedString = string
//        shuffleNode.userInteractionEnabled = true
//        shuffleNode.addTarget(self, action: "shuffleNodeTapped", forControlEvents: ASControlNodeEvent.TouchUpInside)
//        let b = self.view.bounds
//        let size = shuffleNode.measure(CGSize(width: b.size.width, height: CGFloat(FLT_MAX)))
//        let origin = CGPointMake((b.size.width - size.width)/2, (b.size.height - size.height)/2)
//        shuffleNode.frame = CGRect(origin: origin, size: size)
//        self.view.addSubview(shuffleNode.view)
        setupNavigationTitle()
    }
    
    /*
     * 加载新微博
     */
    func loadNewStatus(){
        viewModel.loadNewStatus(asTableView)
    }
    /*
     * 加载更多微博（旧的）
     */
    func loadMoreStatus(){
        viewModel.loadMoreStatus(asTableView)
    }
    /**
     刷新最新的微博
     */
    func refresh(){
        self.asTableView.header.beginRefreshing()
    }
    
    func setupNavigationTitle(){
        // 设置导航栏中间的标题按钮
        let titleButton = YTitleButton()
        // 设置尺寸
        titleButton.height = 35
        // 设置文字
        titleButton.setTitle("首页", forState: .Normal)
        // 设置图标
        titleButton.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Normal)
        // 设置背景
        titleButton.setBackgroundImage(UIImage(named: "navigationbar_filter_background_highlighted"), forState: .Highlighted)
        // 监听按钮点击
        titleButton.addTarget(self, action: "titleClick:", forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = titleButton
        self.titleButton = titleButton
    }
    
    func shuffleNodeTapped(){
        print("成功了")
    }
    
    func titleClick(sender:YTitleButton){
        // 换成箭头向上
        self.titleButton?.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        // 弹出菜单
       
        let button = UIButton(type: .ContactAdd)
        button.backgroundColor = UIColor.blueColor()
        
        let menu = YPopMenu(contentView: button)
        menu.delegate = self
        menu.arrowPosition = .Center
        menu.showInRect(CGRectMake(60, 55, 200, 200))
        //    menu.dimBackground = YES;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //扫描二维码
    func Flicking(){
        let rightViewController = YRightViewController()
        rightViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(rightViewController, animated: true)
    }
    
    func Addbuddy(){
        
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


extension HomeViewController: YPopMenuDelegate{
    func popMenuDidDismissed(popMenu: YPopMenu) {
        self.titleButton!.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Normal)
    }
}

//扩展asyncdisplay的tableview的方法
extension HomeViewController: ASTableViewDelegate,ASTableViewDataSource{
    
    func tableView(tableView: ASTableView!, didEndDisplayingNodeForRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    func tableView(tableView: ASTableView!, willDisplayNodeForRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let node = YStatusNode()
        node.backgroundColor = UIColor.clearColor()
        let model = viewModel.array![indexPath.row] as! YStatusViewModel
        node.viewModel = model
        node.selectionStyle = .None
        
        return node
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRowsInSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return viewModel.numOfSections()
    }
}

