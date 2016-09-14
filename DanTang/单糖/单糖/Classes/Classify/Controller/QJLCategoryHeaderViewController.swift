//
//  QJLCategoryHeaderViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

let categoryCollectionCellID = "QJLCategoryCollectionViewCell"

class QJLCategoryHeaderViewController: QJLBaseViewController {

    var collections = [QJLCollection]()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        // 设置 UI
        setupUI()
        /// 分类界面 顶部 专题合集
        QJLNetworkTool.shareNetworkTool.loadCategoryCollection(6) { (collections) in
            self.collections = collections
            self.collectionView!.reloadData()
        }
    }
    
    // 设置 UI
    private func setupUI() {
        
        let headerView = NSBundle.mainBundle().loadNibNamed(String(QJLTopHeaderView), owner: nil, options: nil)!.last as! QJLTopHeaderView
        headerView.frame = CGRectMake(0, 0, SCREENW, 40)
        headerView.delegate = self
        view.addSubview(headerView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: CGRectMake(0, 40, SCREENW, 95), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: String(QJLCategoryCollectionViewCell), bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: categoryCollectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
}

extension QJLCategoryHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QJLTopHeaderViewDelegate {
    
    // MARK: - YMTopHeaderViewDelegate
    func topViewDidClickedMoreButton(button: UIButton) {
        let seeAllVC = QJLSeeAllController()
        seeAllVC.title = "查看全部"
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryCollectionCellID, forIndexPath: indexPath) as! QJLCategoryCollectionViewCell
        cell.collection = collections[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let collectionDetailVC = QJLCollectionDetailController()
        let collection = collections[indexPath.row]
        collectionDetailVC.title = collection.title
        collectionDetailVC.id = collection.id
        collectionDetailVC.type = "专题合集"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kitemW, kitemH)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }


}
