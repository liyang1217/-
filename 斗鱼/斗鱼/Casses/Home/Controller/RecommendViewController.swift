//
//  RecommendViewController.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/22.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kGameWiewH: CGFloat = 90
private let kCycleViewH: CGFloat = kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    //懒加载属性
    
    fileprivate lazy var gameView : RecommendGameView = {
    
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameWiewH, width: kScreenW, height: kGameWiewH)
        return gameView
    
    }()
    
    //控制器的ViewModel属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH - kGameWiewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
//        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        //设置组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //设置collectionView的高度和宽度随着父控件的伸缩而伸缩
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()

    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
}

//设置UI
extension RecommendViewController{

    fileprivate func setupUI() {
        //1.
        view.addSubview(collectionView)
        //2.cycleView添加到colectionView
        collectionView.addSubview(cycleView)
        //3.gameView添加到colectionView
        collectionView.addSubview(gameView)
        //4. 设置collectionView内边距,让cycleView显示
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameWiewH, left: 0, bottom: 0, right: 0)
        
    }
}

//网络请求
extension RecommendViewController{

    fileprivate func loadData() {
        //推荐数据
        recommendVM.requestData {
            //1. 展示推荐数据
            self.collectionView.reloadData()
            //2. 将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        //轮播数据
        recommendVM.requestCycleData {
            
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//遵守UICollectionViewDataSource协议
extension RecommendViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0. 取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //1. 定义cell
        var cell : CollectionBaseCell!
        //2. 取出cell
        if indexPath.section == 1{
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1. 取出section的headView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2. 取出模型
        headView.group = recommendVM.anchorGroups[indexPath.section]
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}











