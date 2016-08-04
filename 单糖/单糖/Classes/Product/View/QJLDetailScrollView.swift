//
//  QJLDetailScrollView.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLDetailScrollView: UIScrollView {

    var product: QJLProduct? {
        didSet {
            topScrollView.product = product
            bottomScrollView.product = product
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        
        addSubview(topScrollView)
        // 添加底部滚动视图
        addSubview(bottomScrollView)
        
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSizeMake(SCREENW, 520))
        }
        
        bottomScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(topScrollView.snp_bottom).offset(kMargin)
            make.size.equalTo(CGSizeMake(SCREENW, SCREENH - 64 - 45))
        }
    }
    
    /// 顶部滚动视图
    private lazy var topScrollView: QJLProductDetailTopView = {
        let topScrollView = QJLProductDetailTopView()
        topScrollView.backgroundColor = UIColor.whiteColor()
        return topScrollView
    }()
    
    /// 底部滚动视图
    private lazy var bottomScrollView: QJLProductDetailBottomView = {
        let bottomScrollView = QJLProductDetailBottomView()
        bottomScrollView.backgroundColor = UIColor.whiteColor()
        return bottomScrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
