//
//  HomeViewController.swift
//  斗鱼
//
//  Created by BARCELONA on 16/9/20.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    //懒加载属性
     lazy var pageTitleView: PageTitleView = {[weak self] in
    
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles as [NSString])
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = { [weak self] in
        //1. 确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //2. 确定所有的子控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4{
        
            let VC = UIViewController()
            VC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(VC)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentController: self)
        contentView.delegate = self
        return contentView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

//mark - 设置UI界面
extension HomeViewController{
    
    func setupUI(){
        //0. 不需要调整UIScrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1. 设置导航栏
        setupNavigationBar()
        
        //2. 添加titleView
        view.addSubview(pageTitleView)
        
        //3. 添加pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    func setupNavigationBar(){
    //1. 设置左侧的item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2. 设置右侧的item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
}

//遵守PageTitleViewDelegate的协议
extension HomeViewController : PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }

}

//遵守PageContentViewDelegate的协议
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}








