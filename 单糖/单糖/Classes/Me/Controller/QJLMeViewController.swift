//
//  QJLMeViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit


class QJLMeViewController: QJLBaseViewController {
    
    var cellCount = 0
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    /// 创建 tableView
    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
//        tableView.tableFooterView = footerView
    }
    
    private lazy var headerView: QJLMineHeaderView = {
        let headerView = QJLMineHeaderView()
        headerView.frame = CGRectMake(0, 0, SCREENW, kYMMineHeaderImageHeight)
        headerView.iconButton.addTarget(self, action: #selector(iconButtonClick), forControlEvents: .TouchUpInside)
        headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), forControlEvents: .TouchUpInside)
        return headerView
    }()
    
    // MARK: - 头部按钮点击
    func iconButtonClick() {
        // 判断是否登录
        if NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .ActionSheet)
            let cameraAction = UIAlertAction(title: "我的购物车", style: .Default, handler: { (_) in
                
                self.Ordercontroller()
                
                
            })
            let photoAction = UIAlertAction(title: "退出登录", style: .Destructive, handler: { (_) in
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: isLogin)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(photoAction)
            self.presentViewController(actionSheet, animated: true, completion: nil)
        } else {
            let loginVC = QJLLoginViewController()
            loginVC.title = "登录"
            let nav = QJLNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    func messageButtonClick() {
        let messageVC = QJLMessageViewController()
        messageVC.title = "消息"
        navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func settingButtonClick() {
        let settingVC = QJLSettingViewController()
        settingVC.title = "更多"
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
//    private lazy var footerView: QJLMeFooterView = {
//        let footerView = QJLMeFooterView()
//        footerView.width = SCREENW
//        footerView.height = 200
//        return footerView
//    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QJLMeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceView = QJLMeChoiceView()
        choiceView.mineHeadViewClick  = { (type) -> () in
            switch type {
            case .Order:
                let OrderVC = QJLOrderViewController()
                OrderVC.title = "我的订单"
                self.navigationController?.pushViewController(OrderVC, animated: true)
                break
                
            case .Coupon:
                
                print("2")
                break
            case .Message:
                let messageVC = QJLMessageViewController()
                messageVC.title = "消息"
                self.navigationController?.pushViewController(messageVC, animated: true)
  
                break
            }
            }
        
        return choiceView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kYMMineHeaderImageHeight - offsetY
            headerView.bgImageView.frame = tempFrame
        }
        
    }
    
    func Ordercontroller() {
        let OrderVC = QJLOrderViewController()
        OrderVC.title = "我的订单"
        navigationController?.pushViewController(OrderVC, animated: true)
        
    }


}
