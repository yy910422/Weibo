//
//  ScrollViewController.swift
//  新浪微博
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController,UIScrollViewDelegate {

    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        
        for var i = 0; i < 4; i++ {
            let imageName: String = String(format: "new_feature_%d", i + 1)
            let image: UIImage = UIImage(named: imageName)!
            let imageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
            imageView.image = image
            var frame: CGRect = imageView.frame
            frame.origin.x = CGFloat(i) * frame.size.width
            imageView.frame = frame
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSizeMake(4 * self.view.frame.width, self.view.frame.height)
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: "clickScrollView")
        gesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(gesture)
        pageControl.numberOfPages = 4
        pageControl.addTarget(self, action: "changeNum", forControlEvents: UIControlEvents.TouchUpInside)
        pageControl.pageIndicatorTintColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.frame = CGRectMake((self.view.frame.width - 40) / 2,self.view.frame.height - 30,40, 20)
        self.view.addSubview(pageControl)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let width = self.view.frame.width
        let currentX = scrollView.contentOffset.x
        let pageNum = currentX / width
        pageControl.currentPage = Int(pageNum)
    }
    //pageController点击时触发事件
    func changeNum(){
       UIScrollView.animateWithDuration(1) { () -> Void in
        let currentPage = self.pageControl.currentPage
        let width = self.view.frame.width
            self.scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * width, y: self.scrollView.frame.origin.y)
        }
        
    }
    
    func clickScrollView(){
        
        guard pageControl.currentPage == pageControl.numberOfPages - 1 else {
            return
        }
         let rootTabVC =  YTabBarController.shareSingle()
        rootTabVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(rootTabVC, animated: true) { () -> Void in
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
