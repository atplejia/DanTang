//
//  QJLProductDetailViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SnapKit

class QJLProductDetailViewController: QJLBaseViewController,QJLProductDetailToolBarDelegate {

    var product: QJLProduct?
    
    var result: QJLSearchResult?
    
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    /// 设置导航栏和底部栏
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: #selector(shareBBItemClick))
        
        view.addSubview(scrollView)
        // 添加底部栏
        view.addSubview(toolBarView)
        scrollView.product = product
        
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(toolBarView.snp_top)
        }
        
        toolBarView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(45)
        }
        
        scrollView.contentSize = CGSizeMake(SCREENW, SCREENH - 64 - 45 + kMargin + 520)
    }
    
    /// 分享按钮点击
    func shareBBItemClick() {
        QJLActionSheet.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// scrollView
    private lazy var scrollView: QJLDetailScrollView = {
        let scrollView = QJLDetailScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 底部栏
    private lazy var toolBarView: QJLProductDetailToolBar = {
        let toolBarView = NSBundle.mainBundle().loadNibNamed(String(QJLProductDetailToolBar), owner: nil
            , options: nil).last as! QJLProductDetailToolBar
        toolBarView.delegate = self
        return toolBarView
    }()
    
    /// 底部栏按钮点击
    func toolBarDidClickedTMALLButton() {
        let tmallVC = QJLTMALLViewController()
        tmallVC.title = "商品详情"
        tmallVC.product = product
        let nav = QJLNavigationController(rootViewController: tmallVC)
        presentViewController(nav, animated: true, completion: nil)
    }
}

extension QJLProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }


}
