//
//  QJLCategoryViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLCategoryViewController: QJLBaseViewController,QJLCategoryBottomViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: #selector(categoryRightBBClick))
        setupScrollView()

        // Do any additional setup after loading the view.
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        // 顶部控制器
        let headerViewController = QJLCategoryHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRectMake(0, 0, SCREENW, 135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
        
        let bottomBGView = QJLCategoryBottomView(frame: CGRectMake(0, CGRectGetMaxY(topBGView.frame) + 10, SCREENW, SCREENH - 160))
        bottomBGView.backgroundColor = QJLGlobalColor()
        bottomBGView.delegate = self
        scrollView.addSubview(bottomBGView)
        scrollView.contentSize = CGSizeMake(SCREENW, CGRectGetMaxY(bottomBGView.frame))
    }
    
    func categoryRightBBClick() {
        let searchBarVC = QJLSearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    
    /// 懒加载创建 scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.backgroundColor = QJLGlobalColor()
        scrollView.frame = CGRectMake(0, 0, SCREENW, SCREENH)
        return scrollView
    }()
    
    // MARK: - YMCategoryBottomViewDelegate
    func bottomViewButtonDidClicked(button: UIButton) {
        let collectionDetailVC = QJLCollectionDetailController()
        collectionDetailVC.title = button.titleLabel?.text!
        collectionDetailVC.id = button.tag
        collectionDetailVC.type = "风格品类"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
