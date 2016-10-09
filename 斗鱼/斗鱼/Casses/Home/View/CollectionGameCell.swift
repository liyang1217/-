//
//  CollectionGameCell.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/25.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //定义模型属性
    var baseGame : BaseGameModel?{
        didSet{
        
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named:"home_more_btn")
            }
        }
    }
}










