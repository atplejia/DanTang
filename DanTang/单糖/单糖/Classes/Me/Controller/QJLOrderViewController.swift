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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func bulidOrderTableView() {
        orderTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.Plain)
        orderTableView.backgroundColor = view.backgroundColor
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.backgroundColor = UIColor.clearColor()
        orderTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        view.addSubview(orderTableView)
        
        loadOderData()
    }
    
    private func loadOderData() {
        weak var tmpSelf = self
        OrderData.loadOrderData { (data, error) -> Void in
            tmpSelf!.orders = data?.data
            tmpSelf!.orderTableView.reloadData()
        }
    }
}
extension QJLOrderViewController: UITableViewDelegate, UITableViewDataSource, MyOrderCellDelegate {
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = MyOrderCell.myOrderCell(tableView, indexPath: indexPath)
            cell.order = orders![indexPath.row]
            cell.delegate = self
            return cell
        }
        
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 185.0
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return orders?.count ?? 0
        }
        
        func orderCellButtonDidClick(indexPath: NSIndexPath, buttonType: Int) {
            print(buttonType, indexPath.row)
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let orderDetailVC = OrderStatuslViewController()
            orderDetailVC.order = orders![indexPath.row]
            navigationController?.pushViewController(orderDetailVC, animated: true)
        }


}




