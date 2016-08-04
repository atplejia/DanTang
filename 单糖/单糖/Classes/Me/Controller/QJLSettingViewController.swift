//
//  QJLSettingViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD
class QJLSettingViewController: QJLBaseViewController {
    
    var iderVCSendIderSuccess = false

    var settings = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 从 plist 文件在加载数据
        configCellFromPlist()
        
        setupTableView()
    }
    /// 从 plist 文件在加载数据
    func configCellFromPlist() {
        let path = NSBundle.mainBundle().pathForResource("SettingCell", ofType: ".plist")
        let settingsPlist = NSArray.init(contentsOfFile: path!)
        for arrayDict in settingsPlist! {
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let setting = QJLSetting(dict: dict as! [String: AnyObject])
                sections.append(setting)
            }
            settings.append(sections)
        }
    }
    
    /// 创建 tableView
    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        let nib = UINib(nibName: String(QJLSettingCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: messageCellID)
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QJLSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = settings[section] as! [QJLSetting]
        return setting.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageCellID) as! QJLSettingCell
        let setting = settings[indexPath.section] as! [QJLSetting]
        cell.setting = setting[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin + 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        if 0 == indexPath.section {
            
                if 0 == indexPath.row {
                    print("1")
            }
                if 1 == indexPath.row {
                    
                    
                    print("2")
                    
            }
                if 2 == indexPath.row {
                    let IdeaVC = IdeaViewController()
                    IdeaVC.title = "意见反馈"
                    navigationController?.pushViewController(IdeaVC, animated: true)
            }
            
        }
        
         if 1 == indexPath.section {
            
            if 0 == indexPath.row {
                    print("1")
            }
            if 2 == indexPath.row {
                 SVProgressHUD.showWithStatus("正在清理中")
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
              
                SVProgressHUD.showSuccessWithStatus("清理成功")
                })
                
            }

        }
        if 2 == indexPath.section {
            
            let AboutdangTangVC = AboutdangTangController()
            AboutdangTangVC.title = "其他"
            self.navigationController?.pushViewController(AboutdangTangVC, animated: true)
        }
        if 3 == indexPath.section {
            let AboutVC = AboutauthorViewController()
            AboutVC.title = "关于作者"
            navigationController?.pushViewController(AboutVC, animated: true)
        }
        }
    }
    

