//
//  PageContentView.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

//滑动contentView,titleLabel发生响应的变化
protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {

    // 定义属性
    var childVCs : [UIViewController]
    weak var parentController : UIViewController?
    var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    var isForbidScrollDelegate: Bool = false
    
    // 懒加载属性
    lazy var collectionView : UICollectionView = { [weak self] in
    
        //闭包里面用self的话需要用weak修饰,以免产生循环引用
        //可选链的返回类型一定是可选类型
        
        //1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
        
    }()
    
    // 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentController: UIViewController?) {
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
private extension PageContentView{

       func setupUI(){
    
        //1. 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentController?.addChildViewController(childVC)
        }
        //2. 添加collectionView用于在cell中添加控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//遵守UICollectionViewDelegate协议
extension PageContentView : UICollectionViewDelegate{
    //监测scrollView的滚动
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        //当前X的偏移量
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0. 判断是否是点击事件,如果事件事件就不允许执行
        if isForbidScrollDelegate { return }
        
        //1.获取需要的数据
        //滑动的进度
        var progress : CGFloat = 0
        //开始时的下标
        var sourceIndex : Int = 0
        //目标的下表
        var targetIndex : Int = 0
        //2. 判断是左滑还是右滑,//假设是往左边滑,如果滑动结束时的偏移量大于开始滑动时的偏移量,那么就是左滑,否则右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{
            //左边
            //1. 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2. 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3. 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count - 1
            }
            //4. 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
            
                progress = 1
                targetIndex = sourceIndex
            
            }
        } else {
            //右滑
            //1. 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2. 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //3. 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count{
            
                sourceIndex = childVCs.count - 1
            }
        }
        
        //3. 将progres/targetIndex/sourceIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    
    }

}

//遵守UICollectionViewData协议
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

//对外暴露的方法
extension PageContentView{
    
    func setCurrentIndex(currentIndex : Int){
        
        //1. 记录禁止执行代理方法
        isForbidScrollDelegate = true
        
        //2. 滚动到正确的位置
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }

}











