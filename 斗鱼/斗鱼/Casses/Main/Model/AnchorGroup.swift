//
//  AnchorGroup.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/23.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    //房间信息
    var room_list: [[String: NSObject]]?{
        didSet{
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name: String = ""
    //组显示的图标
    var icon_name: String = "home_header_normal"
    //定义主播模型的对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    //构造函数
    override init(){
        
    }
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            if let dataArr = value as? [[String:NSObject]]{
//                for dict in dataArr{
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//            
//        }
//    }
}
