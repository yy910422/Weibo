
import UIKit

typealias plusBtnClickClosure = ()-> Void

class YTabBar: UITabBar {

    weak private var plusBtn: UIButton?
    var plusBtnClickAction: plusBtnClickClosure!
    weak var plusButton:UIButton?{
        if self.plusBtn == nil {
            let btn = UIButton.init(type: UIButtonType.Custom)
            btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
            btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
            btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
            btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
            btn.addTarget(self, action: "plusClick", forControlEvents: .TouchUpInside)
            btn.sizeToFit()
            self.plusBtn = btn
            self.addSubview(plusBtn!)
        }
        return self.plusBtn!
    }
    //点击加号按钮的时候调用
    func plusClick(){
        //modal出控制器
        plusBtnClickAction()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //调整系统自带的tabbar上的按钮的位置
        
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        var btnX: CGFloat = 0
        let btnY: CGFloat = 0
        let btnW = width/CGFloat((self.items?.count)! + 1)
        var i = 0
        for tabBarButton in self.subviews {
            
            if tabBarButton.isKindOfClass(NSClassFromString("UITabBarButton")!){
                if i == 2{
                    i++
                }
                btnX = CGFloat(i) * btnW
                tabBarButton.frame = CGRectMake(btnX, btnY, btnW, height)
                i++
            }
        }
            //设置添加按钮的位置
        self.plusButton!.center = CGPointMake(width * 0.5, height * 0.5)
       // self.plusButton!.bounds = CGRectMake(0, 0, self.plusButton!.currentBackgroundImage!.size.width, self.plusButton!.currentBackgroundImage!.size.height)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */


    
}
