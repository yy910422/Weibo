
import Foundation

/*
* 配置UITableViewCell的内容的closure
*/
typealias TableViewCellConfigureClosure = (NSIndexPath, AnyObject, UITableViewCell) -> Void
/*
* 选中UITableviewCell的closure
*/
typealias DidSelectTableCellClosure = (UITableView,NSIndexPath, AnyObject) -> Void
/*
* UITableViewCell的高度的closure
*/
typealias CellHeightClosure = (NSIndexPath, AnyObject) -> CGFloat
/*
* UITableView的FooterView的closure
*/
typealias ViewForFooterInSectionClosure = (UITableView,Int) -> UIView
/*
* UITableView的HeaderView的closure
*/
typealias ViewForHeaderInSectionClosure = (UITableView,Int) -> UIView


class YTableViewDataDelegate: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    var cellIdentifier = "defaultCell"
    var cellClass:AnyClass?
    var delegate: YTableViewModelDelegate?
    var didSelectCellClosure: DidSelectTableCellClosure?
    var cellConfigureClosure: TableViewCellConfigureClosure?
    var footerViewClosure: ViewForFooterInSectionClosure?
    var headerViewClosure: ViewForHeaderInSectionClosure?
    //初始化方法1
    init(delegate:YTableViewModelDelegate,cellIdentifier:String,cellConfig:TableViewCellConfigureClosure,didSelectClosure:DidSelectTableCellClosure,headerView:ViewForHeaderInSectionClosure?,footerView: ViewForFooterInSectionClosure?) {
        self.delegate = delegate
        self.didSelectCellClosure = didSelectClosure
        self.cellConfigureClosure = cellConfig
        self.cellIdentifier = cellIdentifier
        self.footerViewClosure = footerView
        self.headerViewClosure = headerView
    }
    //初始化方法2
    init(delegate:YTableViewModelDelegate,cellClass:AnyClass,cellConfig:TableViewCellConfigureClosure,didSelectClosure:DidSelectTableCellClosure,headerView:ViewForHeaderInSectionClosure?,footerView: ViewForFooterInSectionClosure?) {
        self.delegate = delegate
        self.didSelectCellClosure = didSelectClosure
        self.cellConfigureClosure = cellConfig
        self.cellClass = cellClass
        self.footerViewClosure = footerView
        self.headerViewClosure = headerView
    }
    
    //获取指定下标的内容
    func itemAtIndexPath(indexPath:NSIndexPath) -> AnyObject{
        return delegate!.itemAtIndex(indexPath)
    }
    
    func handleTableViewDataSourceAndDelegate(tableView:UITableView){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    /*
    **********************实现Tableview的Delegate和Datasource方法****************************
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return delegate!.numOfRowsInSection(section)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return delegate!.numOfSections()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        tableView.registerClass(cellClass, forCellReuseIdentifier: self.cellIdentifier)
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)
        if cell == nil {
           Debug.Log("wq")
        }
        //执行有关tableviewcell的代码
        self.cellConfigureClosure?(indexPath, item!, cell!)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableViewCell.registerTable(tableView, nibIdentifier: self.cellIdentifier)
        return delegate!.heightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.itemAtIndexPath(indexPath)
        self.didSelectCellClosure!(tableView,indexPath,item)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.footerViewClosure?(tableView,section)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate!.heightForFooterInSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate!.heightForHeaderInSection(section)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerViewClosure?(tableView,section)
    }
}