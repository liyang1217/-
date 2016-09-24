//
//  CollectionBaseCell.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/24.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchor : AnchorModel?{
        didSet{
            //0. 校验模型是否有值
            guard let anchor = anchor else {return}
            //1. 取出在线人数显示的人数
            var onlineStr: String = ""
            if anchor.online >= 10000{
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2. 显示昵称
            nickName.text = anchor.nickname
            //3. 显示封面图片
            let URL = NSURL(string: anchor.vertical_src)
            let data = NSData.init(contentsOf: URL as! URL)
            iconImageView.image = UIImage.init(data: data as! Data)
        }
    
    }
    
}
