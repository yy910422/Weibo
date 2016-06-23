
import UIKit

 //添加扩展方法
extension UIBarButtonItem {
    
   //static只实例化一次
    static func item(target: AnyObject,action:Selector,image:String,highImage:String) -> UIBarButtonItem{
        
        let item:UIButton = UIButton()
        //默认的背景图片
        item.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        item.setBackgroundImage(UIImage(named: highImage), forState: UIControlState.Highlighted)
        //设置item的尺寸为当前图片的尺寸
        item.frame.size = item.currentBackgroundImage!.size
        //添加事件
        item.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return UIBarButtonItem(customView: item)
    }
    
}
