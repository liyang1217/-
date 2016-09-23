//
//  AnchorModel.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/23.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    //房间号
    var room_id: Int = 0
    
    //房间图片对应的URLString
    var vertical_src: String = ""
    
    //判断是手机直播还是电脑直播
    //0表示电脑直播, 1表示手机直播
    var isVertical: Int = 0
    
    //所在城市
    var anchor_city: String = ""
    
    //房间名称
    var room_name: String = ""
    
    //主播名称
    var nickname: String = ""
    
    //在线人数
    var online: Int = 0
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

