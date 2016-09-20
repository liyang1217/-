//
//  PageContentView.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    // 定义属性
    var childVCs : [UIViewController]
    var parentController : UIViewController
    
    // 懒加载属性
    lazy var collectionView : UICollectionView = {
    
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
        
    }()
    
    // 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentController: UIViewController) {
        self.childVCs = childVCs
        self.parentController = parentController
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置UI
extension PageContentView{

     func setupUI(){
    
        //1. 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentController.addChildViewController(childVC)
        }
        //2. 添加collectionView用于在cell中添加控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//遵守UICollectionView协议
extension PageContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //2. 
        for view in cell.contentView.subviews {
            //cell是重复利用的,防止重复添加
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.row]
        cell.contentView.addSubview(childVC.view)
        childVC.view.frame = cell.contentView.bounds
        
        return cell
    }
    

}












