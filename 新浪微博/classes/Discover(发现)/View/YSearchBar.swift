/*
自定义搜索框，
create 于杨
date 2012.12.10 
*/

import UIKit

class YSearchBar: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFontOfSize(14)
        self.background = UIImage.resizedImage("searchbar_textfield_background")
        let imgView = UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        imgView.width += 10
        imgView.contentMode = .Center
        self.leftView = imgView
        self.leftViewMode = .Always
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
