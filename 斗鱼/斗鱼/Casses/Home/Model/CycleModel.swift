//
//  CycleModel.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/24.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title: String = ""
    var pic_url: String = ""
    
    //主播信息对应的字典
    var room: [String : NSObject]?{
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    //自定义构造函数
    init(dict : [String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}









