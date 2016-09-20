//
//  UIBarButtonItem-Extension.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //类函数
/*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        btn.setImage((UIImage(named: imageName)), for: .normal)
        btn.setImage((UIImage(named: highImageName)), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size:size)
    
        return UIBarButtonItem(customView: btn)
    }
 */
    //便利构造函数:以convenience开头,在构造函数中必须使用设计的构造函数(self调用)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage((UIImage(named: imageName)), for: .normal)
        if highImageName != ""{
            btn.setImage((UIImage(named: highImageName)), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size:size)
        }
        
        self.init(customView: btn)
    }
}

















