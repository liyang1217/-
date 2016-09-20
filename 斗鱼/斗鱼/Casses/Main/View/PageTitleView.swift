//
//  PageTitleView.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {

    //定义属性
    var titles: [NSString]
    
    // 懒加载属性
    lazy var scrollview : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    lazy var scrollLine :  UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    
    }()
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    
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

    func setupUI(){
    
        //1. 添加UIscrollView
        addSubview(scrollview)
        scrollview.frame = bounds
        
        //2. 添加title对应的label
        setupTitleLabels()
        
        //3. 设置底线和滚动的滑块
        setupBottonMenuAndScrollLine()
    }
    
    private func setupBottonMenuAndScrollLine(){
    
        //1. 添加底线
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: kScrollLineH)
        addSubview(bottonLine)
        
        //2. 添加scrollLine
        //2.1 获取第一个label
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        //2.2 设置属性
        scrollview.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH + lineH)
    }
    
    private func setupTitleLabels(){
        
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
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3. 设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4. label添加到scrollView中
            scrollview.addSubview(label)
            
            
        }
        
    
    }
}














