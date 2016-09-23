//
//  PageTitleView.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

//定义协议
//加上class表示这个协议只能被类遵守, 不写的话可能被别的遵守
//点击titleLabel,通知PageContentView发生相应的变化
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

//定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//定义PageTitleView
class PageTitleView: UIView {
    
    //定义代理属性
     weak var delegate:PageTitleViewDelegate?
    
    

    //定义属性
    fileprivate var titles: [NSString]
    fileprivate var currentIndex : Int = 0
    
    
    // 懒加载属性
    fileprivate lazy var scrollview : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    fileprivate lazy var scrollLine :  UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    
    }()
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    //自定义构造函数
    init(frame: CGRect, titles: [NSString]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{

    fileprivate func setupUI(){
    
        //1. 添加UIscrollView
        addSubview(scrollview)
        scrollview.frame = bounds
        
        //2. 添加title对应的label
        setupTitleLabels()
        
        //3. 设置底线和滚动的滑块
        setupBottonMenuAndScrollLine()
    }
    
    fileprivate func setupBottonMenuAndScrollLine(){
    
        //1. 添加底线
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: kScrollLineH)
        addSubview(bottonLine)
        
        //2. 添加scrollLine
        //2.1 获取第一个label
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        //2.2 设置属性
        scrollview.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH + lineH)
    }
    
    fileprivate func setupTitleLabels(){
        
        //设置label的frame值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        
        for (index, title) in titles.enumerated(){
            //1. 创建UIlabel
            let label = UILabel()
            
            titleLabels.append(label)
            
            //2. 设置属性
            label.text = title as String
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3. 设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. label添加到scrollView中
            scrollview.addSubview(label)
            
            //5. 给label添加手势,响应点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
}

//监听label的点击事件
extension PageTitleView{
    //事件监听需要加上@objc
    @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer){
    
        
        //0. 获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //1. 如果是重复点击同一个title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        //2. 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4. 保存最新label下标值
        currentIndex = currentLabel.tag
    
        //5. 滑条位置的变化
        let scrollViewX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollViewX
        }
        
        //6. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
 
}

//对外暴露的方法
extension PageTitleView{

    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //1. 去除sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2. 处理滑块的逻辑
        //总共要滑动的距离
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        //已经滑动的距离
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3. 颜色的渐变
        //3.1 颜色的变化范围
        //三中颜色的变化范围,RGB
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        //3.2 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4. 记录最新的index
        currentIndex = targetIndex
    }
}













