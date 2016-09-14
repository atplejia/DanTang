//
//  SupermarketViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/4.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD

class SupermarketViewController: SelectedAdressViewController {
    
    private var supermarketData: Supermarket?
    private var categoryTableView: LFBTableView!
    private var productsVC: ProductsViewController!
    
    private var categoryTableViewIsLoadFinish = false
    private var productTableViewIsLoadFinish  = false
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        
        showProgressHUD()
        
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
        navigationController?.navigationBar.barTintColor =  QJLlobalRedColor()

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)
    }
    
    func shopCarBuyProductNumberDidChange() {
        if productsVC.productsTableView != nil {
            productsVC.productsTableView!.reloadData()
        }
    }
    
    // MARK:- Creat UI
    private func bulidCategoryTableView() {
        categoryTableView = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth * 0.25, ScreenHeight), style: .Plain)
        categoryTableView.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        categoryTableView.hidden = true;
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController() {
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.hidden = true
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        productsVC.refreshUpPull = {
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.2 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                Supermarket.loadSupermarketData { (data, error) -> Void in
                    if error == nil {
                        tmpSelf!.supermarketData = data
                        tmpSelf!.productsVC.supermarketData = data
                        tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        tmpSelf!.categoryTableView.reloadData()
                        tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                    }
                }
            })
        }
    }
    
    private func loadSupermarketData() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            weak var tmpSelf = self
            Supermarket.loadSupermarketData { (data, error) -> Void in
                if error == nil {
                    tmpSelf!.supermarketData = data
                    tmpSelf!.categoryTableView.reloadData()
                    tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Bottom)
                    tmpSelf!.productsVC.supermarketData = data
                    tmpSelf!.categoryTableViewIsLoadFinish = true
                    tmpSelf!.productTableViewIsLoadFinish = true
                    if tmpSelf!.categoryTableViewIsLoadFinish && tmpSelf!.productTableViewIsLoadFinish {
                        tmpSelf!.categoryTableView.hidden = false
                        tmpSelf!.productsVC.productsTableView!.hidden = false
                        tmpSelf!.productsVC.view.hidden = false
                        tmpSelf!.categoryTableView.hidden = false
                        SVProgressHUD.dismiss()
                        tmpSelf!.view.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)

                    }
                }
            }
        }
    }
    
    // MARK: - Private Method
    private func showProgressHUD() {
        SVProgressHUD.setBackgroundColor(QJLColor(230, g: 230, b: 230,a: 1))
        view.backgroundColor = UIColor.whiteColor()
        if !SVProgressHUD.isVisible() {
            SVProgressHUD.showWithStatus("正在加载中")
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
        }
    }
    
}

// MARK: - SupermarketViewController
extension SupermarketViewController: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section + 1, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }


}
