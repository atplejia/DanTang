//
//  QJLOrderViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/3.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class QJLOrderViewController: QJLBaseViewController {
    
    var orderTableView: LFBTableView!
    var orders: [Order]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        bulidOrderTableView()
        // Do any additional setup after loading the view.
    }

    private func bulidOrderTableView() {
        
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
//        loadOderData()
    }
    
    private func loadOderData() {
        weak var tmpSelf = self
        OrderData.loadOrderData { (data, error) -> Void in
            tmpSelf!.orders = data?.data
            tmpSelf!.orderTableView.reloadData()
        }
    }


}




