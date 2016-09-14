//
//  AboutdangTangController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD

class AboutdangTangController: QJLBaseViewController {
    
    private var flag: Int = -1
    private var headView: HomeTableHeadView?
    private var collectionView: LFBCollectionView!
    private var lastContentOffsetY: CGFloat = 0
    private var isAnimation: Bool = false
    private var headData: HeadResources?
    private var freshHot: FreshHot?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeNotification()
        
        buildCollectionView()
        
        buildTableHeadView()
        
        buildProessHud()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = QJLlobalRedColor()
        
        if collectionView != nil {
            collectionView.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK:- addNotifiation
    func addHomeNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "homeTableHeadViewHeightDidChange:", name: "HomeTableHeadViewHeightDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goodsInventoryProblem:", name: "HomeGoodsInventoryProblem", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)
    }
    
    // MARK:- Creat UI
    private func buildTableHeadView() {
        headView = HomeTableHeadView()
        
        headView?.delegate = self
        weak var tmpSelf = self
        
        HeadResources.loadHomeHeadData { (data, error) -> Void in
            if error == nil {
                tmpSelf?.headView?.headData = data
                tmpSelf?.headData = data
                tmpSelf?.collectionView.reloadData()
            }
        }
        
        collectionView.addSubview(headView!)
        FreshHot.loadFreshHotData { (data, error) -> Void in
            tmpSelf?.freshHot = data
            tmpSelf?.collectionView.reloadData()
            tmpSelf?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        }
    }
    
    private func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSizeMake(0, 10)
        
        collectionView = LFBCollectionView(frame: CGRectMake(0,66, ScreenWidth, ScreenHeight ), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)

        collectionView.registerClass(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.registerClass(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.registerClass(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        view.addSubview(collectionView)
        
        let refreshHeadView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        refreshHeadView.gifView?.frame = CGRectMake(0, 30, 100, 100)
        collectionView.mj_header = refreshHeadView
    }
    
    // MARK: 刷新
    func headRefresh() {
        headView?.headData = nil
        headData = nil
        freshHot = nil
        var headDataLoadFinish = false
        var freshHotLoadFinish = false
        
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            HeadResources.loadHomeHeadData { (data, error) -> Void in
                if error == nil {
                    headDataLoadFinish = true
                    tmpSelf?.headView?.headData = data
                    tmpSelf?.headData = data
                    if headDataLoadFinish && freshHotLoadFinish {
                        tmpSelf?.collectionView.reloadData()
                        tmpSelf?.collectionView.mj_header.endRefreshing()
                    }
                }
            }
            
            FreshHot.loadFreshHotData { (data, error) -> Void in
                freshHotLoadFinish = true
                tmpSelf?.freshHot = data
                if headDataLoadFinish && freshHotLoadFinish {
                    tmpSelf?.collectionView.reloadData()
                    tmpSelf?.collectionView.mj_header.endRefreshing()
                }
            }
        }
    }
    
    private func buildProessHud() {
        SVProgressHUD.setBackgroundColor(QJLColor(240, g: 240, b: 240,a: 1))
        SVProgressHUD.setFont(UIFont.systemFontOfSize(16))
    }
    
    // MARK: Notifiation Action
    func homeTableHeadViewHeightDidChange(noti: NSNotification) {
        collectionView!.contentInset = UIEdgeInsetsMake(noti.object as! CGFloat, 0, 64, 0)
        collectionView!.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)
        lastContentOffsetY = collectionView.contentOffset.y
    }
    
    func goodsInventoryProblem(noti: NSNotification) {
        if let goodsName = noti.object as? String {
            SVProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: goodsName + "  库存不足了\n先买这么多, 过段时间再来看看吧~")
        }
    }
    
    func shopCarBuyProductNumberDidChange() {
        collectionView.reloadData()
    }
}

// MARK:- HomeHeadViewDelegate TableHeadViewAction
extension AboutdangTangController: HomeTableHeadViewDelegate {
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        if headData?.data?.focus?.count > 0 {
            let path = NSBundle.mainBundle().pathForResource("FocusURL", ofType: "plist")
            let array = NSArray(contentsOfFile: path!)
            let webVC = WebViewController(navigationTitle: headData!.data!.focus![index].name!, urlStr: array![index] as! String)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    func tableHeadView(headView: HomeTableHeadView, iconClick index: Int) {
        if headData?.data?.icons?.count > 0 {
            let webVC = WebViewController(navigationTitle: headData!.data!.icons![index].name!, urlStr: headData!.data!.icons![index].customURL!)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

// MARK:- UICollectionViewDelegate UICollectionViewDataSource
extension AboutdangTangController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if headData?.data?.activities?.count <= 0 || freshHot?.data?.count <= 0 {
            return 0
        }
        
        if section == 0 {
            return headData?.data?.activities?.count ?? 0
        } else if section == 1 {
            return freshHot?.data?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCell
        if headData?.data?.activities?.count <= 0 {
            return cell
        }
        
        if indexPath.section == 0 {
            cell.activities = headData!.data!.activities![indexPath.row]
        } else if indexPath.section == 1 {
            cell.goods = freshHot!.data![indexPath.row]
            weak var tmpSelf = self
            cell.addButtonClick = ({ (imageView) -> () in
            })
        }
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if headData?.data?.activities?.count <= 0 || freshHot?.data?.count <= 0 {
            return 0
        }
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemSize = CGSizeZero
        if indexPath.section == 0 {
            itemSize = CGSizeMake(ScreenWidth - 10 * 2, 140)
        } else if indexPath.section == 1 {
            itemSize = CGSizeMake((ScreenWidth - 10 * 2) * 0.5 - 4, 250)
        }
        
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, 10)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, 10 * 2)
        }
        
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, 10)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, 10 * 5)
        }
        
        return CGSizeZero
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1) {
            return
        }
        
        if isAnimation {
            startAnimation(cell, offsetY: 80, duration: 1.0)
        }
    }
    
    private func startAnimation(view: UIView, offsetY: CGFloat, duration: NSTimeInterval) {
        
        view.transform = CGAffineTransformMakeTranslation(0, offsetY)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            view.transform = CGAffineTransformIdentity
        })
    }
    
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && headData != nil && freshHot != nil && isAnimation {
            startAnimation(view, offsetY: 60, duration: 0.8)
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! HomeCollectionHeaderView
            
            return headView
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HomeCollectionFooterView
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter {
            footerView.showLabel()
            footerView.tag = 100
        } else {
            footerView.hideLabel()
            footerView.tag = 1
        }
        return footerView
    }
    

    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let webVC = WebViewController(navigationTitle: headData!.data!.activities![indexPath.row].name!, urlStr: headData!.data!.activities![indexPath.row].customURL!)
            navigationController?.pushViewController(webVC, animated: true)
        } else {
            let productVC = ProductDetailViewController(goods: freshHot!.data![indexPath.row])
            navigationController?.pushViewController(productVC, animated: true)
        }
    }


}
