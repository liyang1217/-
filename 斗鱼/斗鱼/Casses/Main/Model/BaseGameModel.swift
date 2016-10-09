//
//  BaseGameModel.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/10/9.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    //组显示的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_url : String = ""
    
    //构造函数
    override init(){
        
    }
    
    //自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}


}
