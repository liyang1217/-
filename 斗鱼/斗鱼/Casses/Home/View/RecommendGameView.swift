//
//  RecommendGameView.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/25.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {
    
    //定义数据的属性
    var groups : [AnchorGroup]? {
    
        didSet{
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加"更多"组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //刷新表格
            collectionView.reloadData()
        
        }
    
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
    }
}

//快速创建的类方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//遵守UICollectionViewData协议
extension RecommendGameView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups?[indexPath.item]
        return cell
    }

}














