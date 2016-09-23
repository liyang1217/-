//
//  RecommendViewModel.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/23.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//发送网络请求
extension RecommendViewModel{
    
    //finishCallBack: 请求到数据的回调,用来告诉外界已经请求到数据
    func requestData(finishCallBack: @escaping () -> ()){
        //1. 定义参数
        let parameters = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime() as NSString]
    
        //2. 创建Group,将三组数据按顺序添加进数组
        let disGroup = DispatchGroup.init()
        
        //3. 请求第一部分推荐数据
        //发送一个异步请求时进入组
        disGroup.enter()
        LYNetWorkTools.GetRequestData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrentTime() as NSString]) { (result) in
            //1. 将result装换成字典模型
            guard let resultDict = result as? [String: NSObject] else { return }
            //2. 根据data的key值,获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            //3. 遍历数组,取出字典,并且将字典转换成模型对象
            //3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.1 获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3 离开组
            disGroup.leave()
        }
        
        //4. 请求第二部分颜值数据
        disGroup.enter()
        LYNetWorkTools.GetRequestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //1. 将result装换成字典模型
            guard let resultDict = result as? [String: NSObject] else { return }
            //2. 根据data的key值,获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            //3. 遍历数组,取出字典,并且将字典转换成模型对象
            //3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2 获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            disGroup.leave()
        }
        
        //5. 请求后面部分的游戏数据
        //获取当前时间
        disGroup.enter()
        LYNetWorkTools.GetRequestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //1. 将result装换成字典模型
            guard let resultDict = result as? [String: NSObject] else { return }
            //2. 根据data的key值,获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            //3. 遍历数组,取出字典,并且将字典转换成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                //闭包里面需要写self
                self.anchorGroups.append(group)
            }
            disGroup.leave()
        }
        //6. 所有数据都请求到之后进行排序
        disGroup.notify(qos: .default, flags: .detached, queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            //回调
            finishCallBack()
        }
    }
    
}











