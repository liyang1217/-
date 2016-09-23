//
//  CollectionHeaderView.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/22.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //模型属性
    var group: AnchorGroup?{
    
        didSet{
        
            titleLabel.text = group?.tag_name
            //如果没有值的话就返回默认的home_header_hot
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_hot")
        
        }
    }





}
