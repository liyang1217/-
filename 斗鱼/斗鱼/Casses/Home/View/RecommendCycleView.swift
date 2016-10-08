//
//  RecommendCycleView.swift
//  斗鱼
//
//  Created by BARCELONA on 2016/9/24.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cycleTimer: Timer?
    var cycleModels: [CycleModel]?{
    
        didSet{
        
            collectionView.reloadData()
            //设置pageController的个数
            pageController.numberOfPages = cycleModels?.count ?? 0
            //默认滚到中间某一个位置
             let indexPath = NSIndexPath(item: cycleModels?.count ?? 0, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //添加定时器,先移除再添加
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
//        autoresizingMask = UIViewAutoresizing(rawValue: UInt(0))
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.isPagingEnabled = true
    }
}
//提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView ()->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//遵守UIcollectionViewData协议
extension RecommendCycleView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //如果可选类型没有值的话就返回0
        return (self.cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
         cell.cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
        
         cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
}

//遵守UIcollectionViewDelegate协议
extension RecommendCycleView : UICollectionViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1. 获取滚动的偏移量
        let offSetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2. 计算pageController的currentIndex
        pageController.currentPage = Int(offSetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //手动滚动的时候就不让自动滚动
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//对定时器的操作方法
extension RecommendCycleView{

    fileprivate func addCycleTimer(){
    
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer(){
        //运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func  scrollToNext(){
        //1. 获取滚到的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //2. 滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}












