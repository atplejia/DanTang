//
//  QJLMeViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD

class QJLMeViewController: QJLBaseViewController {
    
    
    // MARK: Lazy Property
    private lazy var mines: [MineCellModel] = {
        let mines = MineCellModel.loadMineCellModels()
        return mines
    }()
    
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
    }
    
    private lazy var headerView: QJLMineHeaderView = {
        let headerView = QJLMineHeaderView()
        headerView.frame = CGRectMake(0, 0, SCREENW, 200)
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
                let CouponVC = CouponViewController()
                CouponVC.title = "优惠券"
                self.navigationController?.pushViewController(CouponVC, animated: true)
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
        
        
        
        return 40
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = MineCell.cellFor(tableView)
        
        if 0 == indexPath.section {
            cell.mineModel = mines[indexPath.row]
            
        } else if 1 == indexPath.section {
            cell.mineModel = mines[2]
            
        } else {
            if indexPath.row == 0 {
                cell.mineModel = mines[3]
                
            } else {
                cell.mineModel = mines[4]
                
            }
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if 0 == indexPath.section {
            
            if 0 == indexPath.row {
                
                let adressVC = MyAdressViewController()
                navigationController?.pushViewController(adressVC, animated: true)
            }
            if 1 == indexPath.row {
                
                let SuperVC = SupermarketViewController()
                self.navigationController?.pushViewController(SuperVC, animated: true)
                
            }
            if 2 == indexPath.row {
                QJLActionSheet.show()
                
            }
            if 3 == indexPath.row{
                let HelpVC = HelpViewController()
                HelpVC.title = "客服帮助"
                self.navigationController?.pushViewController(HelpVC, animated: true)
                
            }
            if 4 == indexPath.row {
                
                let NewsTodayVC = NewsTodayViewController()
                NewsTodayVC.title = "新闻"
                self.navigationController?.pushViewController(NewsTodayVC, animated: true)
            }
            
        }
        
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = 200 - offsetY
            headerView.bgImageView.frame = tempFrame
        }
        
    }
    
    func Ordercontroller() {
        let ShopCartVC = ShopCartViewController()
        ShopCartVC.title = "购物车"
        self.navigationController?.pushViewController(ShopCartVC, animated: true)
        
    }
    
    
    
}
