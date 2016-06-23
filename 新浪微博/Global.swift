import Foundation
import UIKit
//Navigation的title字体
let YNavigationTitleFont = UIFont.systemFontOfSize(15)

let RootViews: [YTabBarModel] = {()->[YTabBarModel] in
    //首页
    let view1 = HomeViewController()
    //消息
    let view2 = MessViewController()
    //发现
    let view3 = FoundViewController()
    //我
    let view4 = MyViewController()
    //消息页面的发送消息按钮
    let sendMessBarItem = YBarButtonItem_Title(title: "发送消息", target: view2, action: "sendMess:")
    //我页面的设置按钮
    let proSetBarItem = YBarButtonItem_Title(title: "发送消息", target: view4, action: "setUpPro:")

    YUserTool.unreadWithSuccess({ (model) -> Void in
        view1.tabBarItem.badgeValue = model.status > 0 ? "\(model.status)" : nil
        view2.tabBarItem.badgeValue = model.messageCount > 0 ? "\(model.messageCount)" : nil
        //view3.tabBarItem.badgeValue = model.status > 0 ? "\(model.status)" : nil
        view4.tabBarItem.badgeValue = model.follower > 0 ? "\(model.follower)" : nil
        }) { (error) -> Void in
            
    }
    let model1 = YTabBarModel(view: view1, title: "首页", image: "tabbar_home", selectedImage: "tabbar_home_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: UIBarButtonItem.item(view1, action: "Flicking", image: "navigationbar_pop", highImage: "navigationbar_pop_highlighted"), leftBarButtonItem: UIBarButtonItem.item(view1, action: "Addbuddy", image: "navigationbar_friendsearch", highImage: "navigationbar_friendsearch_highlighted"))
    let model2 = YTabBarModel(view: view2, title: "消息", image: "tabbar_message_center", selectedImage: "tabbar_message_center_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: sendMessBarItem, leftBarButtonItem: nil)
    let model3 = YTabBarModel(view: view3, title: "搜索", image: "tabbar_discover", selectedImage: "tabbar_discover_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: nil, leftBarButtonItem: nil)
    let model4 = YTabBarModel(view: view4, title: "我", image: "tabbar_profile", selectedImage: "tabbar_profile_selected", fontColor: nil, addNavigation: true, rightBarButtonItem: proSetBarItem, leftBarButtonItem: nil)
    let modelArray = [model1,model2,model3,model4]
    
    return modelArray
}()

    let KeyWindow = UIApplication.sharedApplication().keyWindow

    let DocPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first

    let YMainScreen = UIScreen.mainScreen()

class Debug: NSObject {
    private static let debug = true
    class  func Log(value: Any, fileName: String = __FILE__,line: Int32 = __LINE__) {
        if debug {
            print("文件名称：\(fileName)")
            print("代码行数：\(line)")
            print("调试信息:\(value)")
            print("=======================================")
        }
    }
}
