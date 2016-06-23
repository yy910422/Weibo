//
//  YComposeViewController.swift
//  新浪微博
//
//  Created by 于杨 on 16/3/8.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit
import Alamofire

class YComposeViewController: UIViewController,UITextViewDelegate,YComposeToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    private var _textView: YTextView!
    private var _toolBar: YComposeToolBar!
    private var _photosView: YComposePhotosView!
    private var _rightItem: UIBarButtonItem!
    var images: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //设置导航条
        setUpNavigationBar()
        //添加textView
        setUpTextView()
        //添加工具条
        setUpToolBar()
        // Do any additional setup after loading the view.
        //添加相册视图
        setUpPhotosView()
        
    }
    
    private func setUpPhotosView(){
        
        let photosView = YComposePhotosView(frame:CGRectMake(0,70,self.view.width,self.view.height - 70))
        
        
        self._textView.addSubview(photosView)
        
        self._photosView = photosView
    }
    
    //MARK: 点击工具条按钮的时候调用的协议方法
    func composeToolBar(toolBar: YComposeToolBar, didClickBtn index: Int) {
        
        switch index {
            case 0:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .SavedPhotosAlbum
                self.presentViewController(imagePicker, animated: true, completion: nil)
           
            default:
            print(index)
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //获取选中图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self._photosView.setImage(image)
        self.images.append(image)
        self.dismissViewControllerAnimated(true, completion: nil)
        self._rightItem.enabled = true
    }
    
    private func setUpToolBar() {
        
        let h: CGFloat = 35
        let y = self.view.height  - h
        
        let toolBar = YComposeToolBar(frame: CGRectMake(0,y,self.view.width,h))
        toolBar.delegate = self
        self._toolBar = toolBar
        
        self.view.addSubview(_toolBar)
       
        
    }

    @objc private func keboardFrameChange(note: NSNotification){
        //获取键盘的frame
  
        let frame = note.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        if frame.origin.y == self.view.height {
            _toolBar.transform = CGAffineTransformIdentity
            //没有弹出键盘
        }else{
            //工具条上移
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height)
        }
    }
    
    private func setUpTextView(){
        let textView = YTextView(frame: self.view.bounds)
        textView.font = UIFont.systemFontOfSize(16)
        textView.placeHolder = "你想说点什么呢"
        self.view.addSubview(textView)
        _textView = textView
        _textView.alwaysBounceVertical = true
        /**
        监听文本框的输入
        */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YComposeViewController.textChange), name: UITextViewTextDidChangeNotification, object: textView)
        
        // 监听拖拽
        self._textView.delegate = self
        
    }
    
    
    
    func textChange(){
        if _textView.text != "" {
            _textView.hidePlaceHolder = true
            _rightItem.enabled = true
        }else{
            _textView.hidePlaceHolder = false
            _rightItem.enabled = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        /**
        监听键盘事件
        */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(YComposeViewController.keboardFrameChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        _textView.becomeFirstResponder()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
         NSNotificationCenter.defaultCenter().removeObserver(self)
    }
 
    private func setUpNavigationBar() {
        self.title = "发微博"
        self.navigationItem.leftBarButtonItem = YBarButtonItem_Title(title: "取消",target: self, action: #selector(YComposeViewController.dismiss))
        let  btn = UIButton(type: .Custom)
        btn.sizeToFit()
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitle("发送", forState: .Normal)
        btn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(YComposeViewController.compose), forControlEvents: .TouchUpInside)
        self._rightItem =  UIBarButtonItem(customView: btn)
        _rightItem.enabled = false
         self.navigationItem.rightBarButtonItem = _rightItem
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //发微博
    @objc private func compose() {
        if self.images.count > 0{
            let image = self.images[0]
            let data = UIImagePNGRepresentation(image)
            YComposeTool.composeWithPicStatus(_textView.text, pic: data!, success: { 
                print("success")
                }, failure: { (error) in
                    print(error)
                    print("failure")
            })
        }else{
            YComposeTool.composeWithStatus(_textView.text, success: {
                print("success")
                self.dismissViewControllerAnimated(true, completion: nil)
            }) { (err) in
                
                print("failure")
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
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
