//
//  UIImage+Extension.swift
//  新浪微博
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 yygs. All rights reserved.
//

import UIKit

extension UIImage{
    
    class func imageWithOriginalMode(imageName:String)-> UIImage{
        return UIImage(named: imageName)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
    
    class func resizedImage(name:String)->UIImage{
        let image = UIImage(named: name)!
        return image.stretchableImageWithLeftCapWidth(Int(image.size.width * CGFloat(0.5)), topCapHeight: Int(image.size.height * CGFloat(0.5)))
    }
}
