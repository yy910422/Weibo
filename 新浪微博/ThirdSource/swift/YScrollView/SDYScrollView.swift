//
//  SDYScrollView.swift
//  test
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class SDYScrollView: UIView {

    //MARK: -> Public 属性
    var imageURLS = [String]()
    var titles = [String]()
    
    //MARK: -> Private 属性
    //是否开启自动轮播
    private var autoDisplay = false
    private var timer: NSTimer!
    let cellClassID = "SDYScrollViewCell"
    private var scrollView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    private var pageController: UIPageControl!
    private var currentPage = 0
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupMainView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupMainView()
    }
    /**
     设置主视图相关属性
     */
    private func setupMainView(){
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        scrollView = UICollectionView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), collectionViewLayout: flowLayout)
        scrollView.backgroundColor = UIColor.lightGrayColor()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.registerClass(SDYScrollViewCell.self, forCellWithReuseIdentifier: cellClassID)
        //[mainView registerClass:[SDCollectionViewCell class] forCellWithReuseIdentifier:ID];
        scrollView.dataSource = self
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        pageController = UIPageControl()
        pageController.numberOfPages = imageURLS.count
        self.addSubview(pageController)
    }
    //*******************************************
    //设置轮播相关,timeDelay必须>0 否则不生效
    var timeDelay: Double?{
        didSet{
            if timeDelay > 0 {
                autoDisplay = true
                addTimer()
            }
            
        }
    }
    
    //开启定时器
    private  func addTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(timeDelay!, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        //        let currentRunLoop = NSRunLoop()
        //        currentRunLoop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    //关闭定时器
    private func removeTimer(){
        timer.invalidate()
    }
    //*******************************************
    override func layoutSubviews() {
        super.layoutSubviews()
        print("============")
        print(self.frame)
        scrollView.frame = self.frame
        if scrollView.contentOffset.x == 0 {
            
        }
    }
}

extension SDYScrollView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLS.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellClassID, forIndexPath: indexPath) as! SDYScrollViewCell
        cell.imageURL = imageURLS[indexPath.row]
        if titles.count > 0 {
            cell.title = titles[indexPath.row]
        }
        return cell
    }
}
//MARK: - ScrollView协议事件
extension SDYScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //计算页码
        let scrollerViewW = self.frame.size.width
        let x :CGFloat = scrollView.contentOffset.x
        let page = (scrollerViewW/2 + x)/scrollerViewW
        if page > 0 {
            pageController.currentPage = Int(page-0.5)
            currentPage = Int(page-0.5)
        }
    }
    
    
    //开始拖动时结束定时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if autoDisplay {
            removeTimer()
        }
        
    }
    //结束拖动时重新开启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoDisplay {
            addTimer()
        }
        
    }
}
