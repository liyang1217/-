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
    var group : AnchorGroup?{
        didSet{
        
            titleLabel.text = group?.tag_name
            
            if let iconURL = URL(string: group?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named:"home_more_btn")
            }
            
//            let URL = NSURL(string: group?.icon_url ?? "")!
//            let resource = ImageResource(downloadURL: URL as URL, cacheKey: "")
//            iconImageView.kf.setImage(with: resource, placeholder: UIImage.init(named: "home_header_hot"), options: nil, progressBlock: nil, completionHandler: nil)
            
            
            
            
        }
    
    }
    
    
    
}
