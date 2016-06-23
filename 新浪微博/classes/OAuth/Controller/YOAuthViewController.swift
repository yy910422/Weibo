//
//  YOAuthViewController.swift
//  新浪微博
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

class YOAuthViewController: UIViewController,UIWebViewDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate {

    var session: NSURLSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView(frame: self.view.bounds)
        
        self.view.addSubview(webView)
        //需要配置api.weibo.com的https加密协议，否则无法进行https请求，oauth2 必须用https
        let strUrl = "\(URL_YOAuthorize)?client_id=\(YAppKey)&redirect_uri=\(YRedirectURI)"
        //let strUrl = "https://www.baidu.com"
        let url = NSURL(string: strUrl)
        let request = NSURLRequest(URL: url!)
        webView.delegate = self
        webView.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    func webViewDidStartLoad(webView: UIWebView) {
        ProgressHUD.show("正在加载...", interaction: true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        ProgressHUD.dismiss()
      // ProgressHUD.showSuccess("加载成功")
    }
    //拦截webview请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let strUrl = request.URL?.absoluteString
        let range = strUrl?.rangeOfString("code=" )
        if range?.count > 0 {
            let code = strUrl?.substringFromIndex(range!.endIndex)
            accessToken(code!)
            return false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     获取accessToken
     
     - parameter code: <#code description#>
     */
    func accessToken(code:String){
        
       YAccountTool.accountWithCode(code, success: { () -> Void in
        YAccountTool.checkVersion()
        }, failure: nil)
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
