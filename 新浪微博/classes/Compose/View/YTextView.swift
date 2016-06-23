	//
//  YTextView.swift
//  新浪微博
//
//  Created by 于杨 on 16/3/11.
//  Copyright © 2016年 yygs. All rights reserved.
//

import UIKit

class YTextView: UITextView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var hidePlaceHolder: Bool! {
        didSet{
            placeHolderLabel.hidden = hidePlaceHolder
        }
    }
    override var font: UIFont?{
        get{
            return super.font
        }
        set{
            super.font = newValue
            self.placeHolderLabel.font = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }
    
    private var _placeHolderLabel: UILabel!
    /// 单例模式
    private var placeHolderLabel: UILabel! {
        get{
            if self._placeHolderLabel == nil {
                self._placeHolderLabel = UILabel()
                self.addSubview(self._placeHolderLabel)
                return self._placeHolderLabel
            }else {
                return self._placeHolderLabel
            }
        }
    }

    var placeHolder: String! {
        didSet{
            self.placeHolderLabel.text = placeHolder
            /**
            *  label的尺寸跟文字一样大小
            */
            self.placeHolderLabel.sizeToFit()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeHolderLabel.x = 5
        self.placeHolderLabel.y = 8
    }
    
}
