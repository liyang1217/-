//
//  NSDateExtension.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/23.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

extension NSDate{

    class func getCurrentTime() -> String{
    
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)" 
    
    }

}





