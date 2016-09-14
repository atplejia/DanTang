//
//  PopPresentationController.swift
//  单糖
//
//  Created by 金亮齐 on 16/9/13.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class PopPresentationController: UIPresentationController {
    
    /// 定义弹出视图的大小
    var presentFrame = CGRectZero
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
    }
    
    /// 即将布局转场子视图时调用
    override func containerViewWillLayoutSubviews() {
        
        containerView?.insertSubview(coverView, atIndex: 0)
        // 修改弹出视图的尺寸
        presentedView()?.frame = presentFrame
    }
    
    private lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        coverView.frame = UIScreen.mainScreen().bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissCoverView))
        coverView.addGestureRecognizer(tap)
        return coverView
    }()
    
    func dismissCoverView() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
