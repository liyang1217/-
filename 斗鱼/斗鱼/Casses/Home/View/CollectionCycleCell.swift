//
//  CollectionCycleCell.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/25.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //定义模型属性
    var cycleModel : CycleModel?{
    
        didSet{
            titleLabel.text = cycleModel?.title
            let URL = NSURL(string: (cycleModel?.pic_url)!)
            let resource = ImageResource.init(downloadURL: URL as! URL)
            iconImageView.kf.setImage(with: resource)
//            let data = NSData.init(contentsOf: URL as! URL)
//            iconImageView.image = UIImage.init(data: data as! Data)
        }
    }
}
