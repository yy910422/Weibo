//
//  UITableViewCell+Extensions.swift
//  新浪微博
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 yygs. All rights reserved.
//

import Foundation

extension UITableViewCell {
    
    class internal func nibWithIdentifier(identifier: String) -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    /**
     *  从nib文件中根据重用标识符注册UITableViewCell
     */
    class func registerTable(table: UITableView, nibIdentifier identifier: String) {
        return table.registerNib(self.nibWithIdentifier(identifier), forCellReuseIdentifier: identifier)
    }
    /**
     *  配置UITableViewCell，设置UITableViewCell内容
     */
    func configure(cell: UITableViewCell, customObj obj: AnyObject, indexPath: NSIndexPath) {
        // Rewrite this func in SubClass !
    }
}