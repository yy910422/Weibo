import UIKit

protocol YComposeToolBarDelegate{
    func composeToolBar(toolBar: YComposeToolBar, didClickBtn index: Int)
}

class YComposeToolBar: UIView {

    var delegate: YComposeToolBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加所有的子控件
        setUpAllChildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     添加所有子控件
     */
    private func setUpAllChildView(){
        //相册
        setUpButtonWithImage(self, action: "picutreBtnClick:", image: UIImage(named: "compose_toolbar_picture")!, highImage: UIImage(named: "compose_toolbar_picture_highlighted")!)
        //提及
        setUpButtonWithImage(self, action: "picutreBtnClick:", image: UIImage(named: "compose_mentionbutton_background")!, highImage: UIImage(named: "compose_mentionbutton_background_highlighted")!)
        //话题
        setUpButtonWithImage(self, action: "picutreBtnClick:", image: UIImage(named: "compose_trendbutton_background")!, highImage: UIImage(named: "compose_trendbutton_background_highlighted")!)
        //表情
        setUpButtonWithImage(self, action: "picutreBtnClick:", image: UIImage(named: "compose_emoticonbutton_background")!, highImage: UIImage(named: "compose_emoticonbutton_background_highlighted")!)
        //键盘
        setUpButtonWithImage(self, action: "picutreBtnClick:", image: UIImage(named: "compose_keyboardbutton_background")!, highImage: UIImage(named: "compose_keyboardbutton_background_highlighted")!)
    }
    
    @objc private func picutreBtnClick(button: UIButton){
        if delegate != nil {
            self.delegate.composeToolBar(self, didClickBtn: button.tag)
        }
    }
    
    private func setUpButtonWithImage(target: AnyObject,action:Selector,image:UIImage,highImage:UIImage){
        
        let item:UIButton = UIButton()
        //默认的背景图片
        item.setImage(image, forState: UIControlState.Normal)
        item.setImage(highImage, forState: UIControlState.Highlighted)
        item.sizeToFit()
        item.tag = self.subviews.count
        //设置item的尺寸为当前图片的尺寸
       // item.frame.size = item.currentBackgroundImage!.size
        //添加事件
        item.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(item)
    }
    
    override func layoutSubviews() {
       
        let count: Int = self.subviews.count
        let width = self.width/CGFloat(count)
        let height = self.height
        var x: CGFloat = 0
        let y: CGFloat = 0
        for (var i = 0 ; i < count ; i++ ) {
            let btn: UIButton = self.subviews[i] as! UIButton
            x = width * CGFloat(i)
            btn.frame = CGRectMake(x, y, width, height)
            
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
