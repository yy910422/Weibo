//
//  YNewFeatureController.swift
//  新浪微博
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

private let reuseIdentifier = "YCell"

class YNewFeatureController: UICollectionViewController {
    
    var pageControl: UIPageControl!

    init(){
        let layout = UICollectionViewFlowLayout()

        //设置cell的尺寸
        layout.itemSize = UIScreen.mainScreen().bounds.size
        //清除行间距
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        super.init(collectionViewLayout: layout)
    }

    //不能在storyboard中使用
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.pagingEnabled = true
        self.collectionView?.bounces = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(YCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        setUpPageControl()
        // Do any additional setup after loading the view.
    }
    //配置页码控制器
    private func setUpPageControl(){
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 10)
        self.view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //页面发生滚动时会触发此方法
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        self.pageControl.currentPage = page
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! YCollectionViewCell
    
        let screenH = UIScreen.mainScreen().bounds.size.height
        
        var imageName = String(format: "new_feature_%d", indexPath.row + 1)
//        if screenH > 480 {
//            imageName = String(format: "new_featrue_%ld-568h", indexPath.row + 1)
//        }
        cell.image = UIImage(named: imageName)
        cell.setIndexPath(indexPath, count: 4)
        // Configure the cell
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
