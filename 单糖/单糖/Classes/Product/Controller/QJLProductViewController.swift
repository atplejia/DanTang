//
//  QJLProductViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

let collectionCellID = "QJLCollectionViewCell"

class QJLProductViewController: QJLBaseViewController {
    
    var products = [QJLProduct]()
    
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置collectionView
        setupCollectionView()
        
        weak var weakSelf = self
        QJLNetworkTool.shareNetworkTool.loadProductData { (products) in
            weakSelf!.products = products
            weakSelf!.collectionView!.reloadData()
        }
    }
    
    /// 设置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String(QJLCollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QJLProductViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, QJLCollectionViewCellDelegate {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! QJLCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = QJLProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.product = products[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let loginVC = QJLLoginViewController()
            loginVC.title = "登录"
            let nav = QJLNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        } else {
            
        }
    }


}
