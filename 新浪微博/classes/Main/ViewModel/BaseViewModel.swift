import Foundation
import Alamofire

class BaseViewModel{
    
    /**
     Get方法获取数据
     
     - parameter url:     服务器地址
     - parameter params:  请求参数
     - parameter success: 成功时调用的closure
     - parameter failure: 失败时调用的closure
     */
    func getDataList(url: String!, params: NSDictionary, success: ((AnyObject!) -> Void)!, failure: ((NSError!) -> Void)!) {
        request(.GET, url, parameters: params as? [String : AnyObject], encoding: .URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                let dic = response.result.value as! NSDictionary
                success(dic)
                //保存当前登录人
                //self.delegate?.loginSuccess(model)
                //ProgressHUD.showSuccess("登录成功",interaction: true)
            }else{
                ProgressHUD.showError("网络异常，请求失败", interaction: true)
            }
        }
    }
    /**
     Post方法提交数据
     
     - parameter url:     服务器地址
     - parameter params:  请求参数（这里会添加到http的body中）
     - parameter success: 成功时调用的closure
     - parameter failure: 失败时调用的closure
     */
    func postDataList(url: String!, params: NSDictionary, success: ((AnyObject!) -> Void)!, failure: ((NSError!) -> Void)!) {
        request(.POST, url, parameters: params as? [String : AnyObject], encoding: .URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                let dic = response.result.value as! NSDictionary
                success(dic)
                //保存当前登录人
                //self.delegate?.loginSuccess(model)
                //ProgressHUD.showSuccess("登录成功",interaction: true)
            }else{
                ProgressHUD.showError("网络异常，请求失败", interaction: true)
            }
        }
    }
    
}
