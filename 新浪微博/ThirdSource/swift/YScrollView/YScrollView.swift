//
//  YScrollerView.swift
//  test
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 于杨. All rights reserved.
//

import UIKit
import Foundation

class YScrollView: UIView,UIScrollViewDelegate {
    
    weak var delegate: YScrollViewDelegate?
    //页码控制器的位置
    enum PageControllerDirection{
        case Center
        case Left
        case Right
    }
    private var subFrame: CGRect!
    //滚动视图
    private var scrollView: UIScrollView!
    private var currentPage: Int = 0
    private var pageController: UIPageControl!
    //是否显示页码控制器
    var showPageController: Bool?{
        didSet{
            if showPageController! {
                self.setPageController(pageDirection)
                //设置PageController
            }else{
                //移除PageController
                for controller in self.subviews{
                    if controller == pageController {
                        controller.removeFromSuperview()
                    }
                }
            }
        }
    }
    //设置页码控制器的位置(默认是居中的)
    var pageDirection: PageControllerDirection = .Center{
        didSet{
            changePageControllerDirection(pageDirection)
        }
    }
    //设置图片，添加图片
    var pageImagesURL: [NSURL]!{
        didSet{
            addImage(pageImagesURL)
        }
    }
    //滚动视图的页数
    var pageCount: Int = 0{
        didSet{
            redrawScrollViewContentSize()
        }
    }
    //通过代码初始化
    override init(frame: CGRect) {
        super.init(frame:frame)
        pageController = UIPageControl()
        pageDirection = .Center
        self.initScrollView()
        subFrame = self.frame
    }
    //通过sb初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pageController = UIPageControl()
        pageDirection = .Center
        self.initScrollView()
        subFrame = self.frame
    }
    
    //自定义初始化构造器
    convenience init(frame: CGRect,pageCount:Int,imageURLs:[NSURL],pageControllerDirection:PageControllerDirection) {
        self.init(frame:frame)
        pageDirection = pageControllerDirection
        
    }
    
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
    
    //******************************************
    //私有化方法
    //初始化scrollView
    private func initScrollView(){
        print("initScrollView加载")
        //ios7 以后的支持
        self.backgroundColor = UIColor.lightGrayColor()
        scrollView = UIScrollView()
         scrollView.backgroundColor = UIColor.redColor()
        //设置分页
        scrollView.pagingEnabled = true
        //设置代理
        scrollView.delegate = self
        //隐藏指示条
        scrollView.showsHorizontalScrollIndicator = false
        //添加个点击事件
        let gesture = UITapGestureRecognizer(target: self, action: "clickScrollView:")
        gesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(gesture)
        
        
        pageController = UIPageControl()
        self.addSubview(scrollView)
    }
    //scrollview添加图片
    private func addImage(images:[NSURL]){
        print("addImage加载")
        pageCount = images.count
        for value in images {
           // let imgX = self.frame.width * CGFloat(index)
            let imgView = UIImageView()
            imgView.userInteractionEnabled = true
            //缓存处理img，如果根据网络地址请求不到，则添加默认图片
            imgView.sd_setImageWithURL(value, placeholderImage: UIImage(named: "default.jpg"))
            //设置填充模式
            imgView.contentMode = UIViewContentMode.ScaleToFill
            scrollView.addSubview(imgView)
        }
    }
    
    func clickScrollView(sender:UIScrollView){
        self.delegate?.yScrollView!(sender, didClickAtIndex: self.currentPage)
    }
    /**
     初始化页码控制器
     - parameter direction: 页码控制器所在方向
     */
    private  func setPageController(direction:PageControllerDirection){
        print("setPageController加载")
      
        //如果用户设置不显示PageController 则不添加pageController
        guard showPageController! else{
            return
        }
        let number: Int = pageCount == 0 ? pageImagesURL.count:pageCount
        changePageControllerDirection(direction)
        //禁止点击
        pageController.hidesForSinglePage = true
        pageController.userInteractionEnabled = false
        pageController.numberOfPages = number
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.grayColor()
        pageController.backgroundColor = UIColor.clearColor()
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
        self.addSubview(self.pageController)
        }
    }
    /**
    *  更改PageController的位置
    */
    private func changePageControllerDirection(direction:PageControllerDirection){
        let number: Int = pageCount == 0 ? pageImagesURL.count:pageCount
        //页码控制器的宽
        let pageControllerWidth: CGFloat = CGFloat(number * 10)
        //页码控制器的高
        let pageControllerHeight:CGFloat = 10
        //页码控制器的y坐标
        let pageControllerY = scrollView.frame.height - 20
        var frame:CGRect!
        switch direction {
        case .Center:
            let x = (scrollView.frame.width - pageControllerWidth)/2
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        case .Left:
            let x: CGFloat = 30
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        case .Right:
            let x: CGFloat = scrollView.frame.width - pageControllerWidth - 10
            frame = CGRectMake(x, pageControllerY, pageControllerWidth, pageControllerHeight)
        }
        pageController.frame = frame
    }
    //私有化方法结束
    
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
    //是否开启自动轮播
    private var autoDisplay = false
    //定时器
    private var timer: NSTimer?
    //开启定时器
    private  func addTimer(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(timeDelay!, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        //        let currentRunLoop = NSRunLoop()
        //        currentRunLoop.addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    //关闭定时器
    private func removeTimer(){
        timer!.invalidate()
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
    //自动换图
    func nextImage(){
        var page = self.currentPage
        if page == pageImagesURL.count - 1 {
            page = 0
            scrollView.scrollsToTop = true
        }else{
            page++
        }
        
        //算当前页面图片坐标
        let x = CGFloat(page) * self.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y: 0), animated: true)
        self.pageController.currentPage = page
        self.currentPage = page
    }
    override func layoutSubviews() {
        redrawScrollView()
        redrawScrollViewContentSize()
        redrawImageViews()
        changePageControllerDirection(pageDirection)
    }
    
    //更新scrollView的frame
    func redrawScrollView(){
        let scrollViewFrame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        scrollView.frame = scrollViewFrame
    }
    //更新scrollView中的imageView的frame
    func redrawImageViews(){
        for(index,value) in scrollView.subviews.enumerate(){
            let imgX = self.frame.width * CGFloat(
                index)
            let frame = CGRectMake(imgX, 0, self.frame.width, self.frame.height)
            value.frame = frame
        }
    }
    //更新scrollView的滚动范围
    func redrawScrollViewContentSize(){
        //图片的宽
        let imgW = self.scrollView.bounds.width
        //设置滚动范围
        let contentW = imgW * CGFloat(pageCount)
        //不允许在垂直方向进行滚动
        scrollView.contentSize = CGSizeMake(contentW, 0)
    }
}


