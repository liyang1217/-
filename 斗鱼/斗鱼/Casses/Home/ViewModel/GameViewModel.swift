//
//  GameViewModel.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/10/9.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel{
    
    func loadAllgamesData(finishedCallBack : @escaping () -> ()){
        
        LYNetWorkTools.GetRequestData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            //1. 获取数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //2. 字典转模型
            for dict in dataArray {
                
                self.games.append(GameModel(dict: dict))
                
            }
            //3. 完成回调
            finishedCallBack()
        }
    }

}







