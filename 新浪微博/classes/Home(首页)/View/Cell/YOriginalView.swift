
import UIKit

class YOriginalView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    /// 头像
    var iconView: UIImageView!
    /// vip
    var vipView: UIImageView!
    /// 昵称
    var nameView: UILabel!
    /// 时间
    var timeView: UILabel!
    /// 来源
    var sourceView: UILabel!
    /// 正文
    var textView: UILabel!
    /// 配图
    var photosView: YPhotosView!
    
    
    var viewModel: YStatusViewModel! {
        didSet{
            iconView.frame = viewModel.originalIconFrame
            if viewModel.status.user.vip {
                //昵称设置成橘红色
                nameView.textColor = UIColor.orangeColor()
                //显示vip图标
                vipView.hidden = false
                 vipView.frame = viewModel.originalVipFrame
            }else{
                vipView.hidden = true
                //昵称设置成黑色
                nameView.textColor = UIColor.blackColor()
            }
           
            nameView.frame = viewModel.originalNameFrame
            //timeView.frame = viewModel.originalTimeFrame
            let timeX = nameView.frame.origin.x
            let timeY = CGRectGetMaxY(nameView.frame) + CGFloat(YStatusCellMargin)
            let timeSize = (viewModel.status.created_at_fmt as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13)])
            timeView.frame = CGRect(origin: CGPoint(x: timeX,y: timeY), size: timeSize)
            
            let sourceX = CGRectGetMaxX(timeView.frame) + CGFloat(YStatusCellMargin)
            let sourceY = timeY
            let sourceSize = (viewModel.status.source_fmt as NSString).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(12)])
             sourceView.frame = CGRect(origin: CGPoint(x: sourceX,y: sourceY), size: sourceSize)
           // sourceView.frame = viewModel.originalSourceFrame
            textView.frame = viewModel.originalTextFrame
            
            //配图
            photosView.frame = viewModel.originalPhotosFrame
            setUpData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加所有子控件
        setUpAllChildView()
        self.userInteractionEnabled = true
        self.image = UIImage.resizedImage("timeline_card_top_background")
      
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpData(){
        
        let status = viewModel.status
        //头像
        iconView.sd_setImageWithURL(NSURL(string: status.user.profile_image_url), placeholderImage: UIImage(named: "timeline_image_placeholder"))
        //昵称
        nameView.text = status.user.name
        //vip
        let member = "common_icon_membership_level\(status.user.mbrank)"
        vipView.image = UIImage(named: member)
        //时间
        timeView.text = status.created_at_fmt
        
        //来源
        sourceView.text = status.source_fmt
        //正文
        textView.text = status.text
        //配图
        photosView.pic_urls = status.pic_urls
    }
    /**
     添加所有子控件
     */
    func setUpAllChildView(){
        
        //头像
        iconView = UIImageView()
        self.addSubview(iconView)
        //昵称
        nameView = UILabel()
        nameView.font = UIFont.systemFontOfSize(13)
        self.addSubview(nameView)
        //vip
         vipView = UIImageView()
        self.addSubview(vipView)
        //时间
        timeView = UILabel()
        timeView.textColor = UIColor.grayColor()
        timeView.font = UIFont.systemFontOfSize(12)
        self.addSubview(timeView)
        //来源
        sourceView = UILabel()
        sourceView.textColor = UIColor.grayColor()
        sourceView.font = UIFont.systemFontOfSize(12)
    
        self.addSubview(sourceView)
        //正文
        textView = UILabel()
        textView.font = UIFont.systemFontOfSize(13)
        textView.numberOfLines = 0
        self.addSubview(textView)
        //配图 
        photosView = YPhotosView()
        self.addSubview(photosView)
    }
}
